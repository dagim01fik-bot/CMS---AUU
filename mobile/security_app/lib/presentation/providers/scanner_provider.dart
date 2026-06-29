import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_constants.dart';
import '../../core/storage/scan_cache_store.dart';
import '../../core/storage/scan_history_store.dart';
import '../../data/models/verify_student_id_request.dart';
import '../../data/models/verify_student_id_response.dart';
import 'auth_provider.dart';

final scanCacheStoreProvider = Provider<ScanCacheStore>((ref) {
  return ScanCacheStore();
});

final scanHistoryStoreProvider = Provider<ScanHistoryStore>((ref) {
  return ScanHistoryStore();
});

final scannerProvider = StateNotifierProvider<ScannerNotifier, ScannerState>((ref) {
  return ScannerNotifier(
    ref: ref,
    cacheStore: ref.watch(scanCacheStoreProvider),
    historyStore: ref.watch(scanHistoryStoreProvider),
  );
});

class ScannerNotifier extends StateNotifier<ScannerState> {
  ScannerNotifier({
    required Ref ref,
    required ScanCacheStore cacheStore,
    required ScanHistoryStore historyStore,
  })  : _ref = ref,
        _cacheStore = cacheStore,
        _historyStore = historyStore,
        super(const ScannerState());

  final Ref _ref;
  final ScanCacheStore _cacheStore;
  final ScanHistoryStore _historyStore;
  String? _lastAcceptedToken;
  DateTime? _lastAcceptedAt;

  Future<void> handleScan(String rawToken) async {
    final token = rawToken.trim();
    if (token.isEmpty || state.isVerifying) {
      return;
    }

    final now = DateTime.now();
    final isDuplicate = _lastAcceptedToken == token &&
        _lastAcceptedAt != null &&
        now.difference(_lastAcceptedAt!) < ApiConstants.duplicateScanThrottle;
    if (isDuplicate) {
      return;
    }

    _lastAcceptedToken = token;
    _lastAcceptedAt = now;
    final authState = _ref.read(authProvider);
    if (!authState.isAuthenticated) {
      state = const ScannerState(
        errorTitle: 'FAILED',
        errorMessage: 'Please sign in again before scanning.',
      );
      return;
    }

    state = const ScannerState(isVerifying: true);
    try {
      final response = await _ref.read(securityApiClientProvider).verifyStudentId(
            accessToken: authState.accessToken,
            request: VerifyStudentIdRequest(
              opaqueToken: token,
              deviceTag: authState.deviceTag,
            ),
          );
      await _cacheStore.save(
        opaqueToken: token,
        deviceTag: authState.deviceTag,
        response: response,
      );
      await _historyStore.save(response);
      _showResult(response);
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        await _ref.read(authProvider.notifier).logout();
        state = const ScannerState(
          errorTitle: 'FAILED',
          errorMessage: 'Session expired. Please sign in again.',
        );
        return;
      }

      if (_shouldUseOfflineFallback(error)) {
        final cached = await _cacheStore.read(
          opaqueToken: token,
          deviceTag: authState.deviceTag,
        );
        if (cached != null) {
          await _historyStore.save(cached);
          _showResult(cached);
        } else {
          state = const ScannerState(
            errorTitle: 'FAILED',
            manualWarning: 'OFFLINE — VERIFY MANUALLY',
            errorMessage: 'Server unreachable. No trusted cached verification found.',
          );
        }
        return;
      }

      state = _buildFailureState(error);
    } catch (_) {
      state = const ScannerState(
        errorTitle: 'FAILED',
        errorMessage: 'Verification failed. Please try again.',
      );
    }
  }

  void clear() {
    _lastAcceptedToken = null;
    _lastAcceptedAt = null;
    state = const ScannerState();
  }

  void _showResult(VerifyStudentIdResponse response) {
    state = ScannerState(
      isVerifying: false,
      lastResult: response,
      manualWarning: response.warningMessage,
    );
  }

  bool _shouldUseOfflineFallback(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  ScannerState _buildFailureState(DioException error) {
    final responseData = error.response?.data;
    if (responseData is Map<String, dynamic>) {
      final code = responseData['code'] as String?;
      if (code != null && code.isNotEmpty) {
        return ScannerState(
          errorTitle: _buildErrorTitle(code),
          errorMessage: _buildErrorMessageFromCode(code),
        );
      }

      final message = responseData['message'] as String? ??
          responseData['detail'] as String? ??
          responseData['title'] as String?;
      if (message != null && message.trim().isNotEmpty) {
        return ScannerState(
          errorTitle: 'FAILED',
          errorMessage: message.trim(),
        );
      }
    }

    return const ScannerState(
      errorTitle: 'FAILED',
      errorMessage: 'Verification failed. Please try again.',
    );
  }

  String _buildErrorTitle(String code) {
    switch (code) {
      case 'invalid_token':
      case 'credential_inactive':
      case 'student_inactive':
      case 'student_suspended':
        return 'UNVERIFIED';
      default:
        return 'FAILED';
    }
  }

  String _buildErrorMessageFromCode(String code) {
    switch (code) {
      case 'invalid_token':
        return 'Student QR is invalid or no longer trusted.';
      case 'credential_inactive':
        return 'Student credential is inactive.';
      case 'student_inactive':
        return 'Student account is inactive.';
      case 'student_suspended':
        return 'Student is suspended and cannot be verified.';
      case 'device_mismatch':
        return 'This scan device is not allowed for the current checkpoint.';
      default:
        return 'Verification failed. Please try again.';
    }
  }
}

class ScannerState {
  const ScannerState({
    this.isVerifying = false,
    this.lastResult,
    this.errorTitle,
    this.errorMessage,
    this.manualWarning,
  });

  final bool isVerifying;
  final VerifyStudentIdResponse? lastResult;
  final String? errorTitle;
  final String? errorMessage;
  final String? manualWarning;
}
