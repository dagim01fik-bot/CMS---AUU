import 'package:dio/dio.dart';

import '../storage/secure_session_storage.dart';
import 'api_client.dart';

class StudentQrData {
  const StudentQrData({
    required this.opaqueToken,
    required this.studentId,
    required this.displayName,
  });

  final String opaqueToken;
  final String studentId;
  final String displayName;
}

class StudentIdService {
  StudentIdService({
    ApiClient? apiClient,
    SecureSessionStorage? sessionStorage,
  })  : _apiClient = apiClient ?? ApiClient(),
        _sessionStorage = sessionStorage ?? SecureSessionStorage();

  final ApiClient _apiClient;
  final SecureSessionStorage _sessionStorage;

  Future<StudentQrData> fetchQr() async {
    final token = await _sessionStorage.readAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('You must sign in before opening the student ID QR.');
    }

    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      '/student-id/qr',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final data = response.data ?? const <String, dynamic>{};
    return StudentQrData(
      opaqueToken: data['opaqueToken'] as String? ?? '',
      studentId: data['studentId'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
    );
  }
}
