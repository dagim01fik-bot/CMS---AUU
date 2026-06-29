import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/secure_session_storage.dart';
import '../../data/api/security_api_client.dart';
import '../../data/models/security_login_request.dart';

final securityApiClientProvider = Provider<SecurityApiClient>((ref) {
  return SecurityApiClient();
});

final secureSessionStorageProvider = Provider<SecureSessionStorage>((ref) {
  return SecureSessionStorage();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    apiClient: ref.watch(securityApiClientProvider),
    sessionStorage: ref.watch(secureSessionStorageProvider),
  )..bootstrap();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required SecurityApiClient apiClient,
    required SecureSessionStorage sessionStorage,
  })  : _apiClient = apiClient,
        _sessionStorage = sessionStorage,
        super(const AuthState());

  final SecurityApiClient _apiClient;
  final SecureSessionStorage _sessionStorage;

  Future<void> bootstrap() async {
    final session = await _sessionStorage.readSession();
    if (session != null) {
      if (_isTokenExpired(session.accessToken)) {
        await _sessionStorage.clearSession();
        state = state.copyWith(
          errorMessage: 'Session expired. Please sign in again.',
        );
        return;
      }

      state = state.copyWith(
        accessToken: session.accessToken,
        officerName: session.officerName,
        officerBadge: session.officerBadge,
        deviceTag: session.deviceTag,
        checkpointName: session.checkpointName,
        isAuthenticated: true,
      );
    }
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final installationId = await _sessionStorage.getOrCreateInstallationId();
      final response = await _apiClient.login(
        SecurityLoginRequest(
          identifier: identifier,
          password: password,
          installationId: installationId,
        ),
      );
      await _sessionStorage.saveSession(response);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        accessToken: response.accessToken,
        officerName: response.officer.fullName,
        officerBadge: response.officer.badgeNumber,
        checkpointName: response.checkpoint.name,
        deviceTag: response.checkpoint.deviceTag,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to sign in. Check credentials or device assignment.',
      );
    }
  }

  Future<void> logout() async {
    await _sessionStorage.clearSession();
    state = const AuthState();
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return true;
      }

      final normalized = base64Url.normalize(parts[1]);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)))
          as Map<String, dynamic>;
      final exp = payload['exp'];
      if (exp is! num) {
        return true;
      }

      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        exp.toInt() * 1000,
        isUtc: true,
      );
      return DateTime.now().toUtc().isAfter(expiresAt);
    } catch (_) {
      return true;
    }
  }
}

class AuthState {
  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage,
    this.accessToken = '',
    this.officerName = '',
    this.officerBadge = '',
    this.deviceTag = '',
    this.checkpointName = '',
  });

  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;
  final String accessToken;
  final String officerName;
  final String officerBadge;
  final String deviceTag;
  final String checkpointName;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
    String? accessToken,
    String? officerName,
    String? officerBadge,
    String? deviceTag,
    String? checkpointName,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
      accessToken: accessToken ?? this.accessToken,
      officerName: officerName ?? this.officerName,
      officerBadge: officerBadge ?? this.officerBadge,
      deviceTag: deviceTag ?? this.deviceTag,
      checkpointName: checkpointName ?? this.checkpointName,
    );
  }
}
