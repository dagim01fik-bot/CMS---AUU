import '../storage/secure_session_storage.dart';
import 'api_client.dart';

class AuthService {
  AuthService({
    ApiClient? apiClient,
    SecureSessionStorage? sessionStorage,
  })  : _apiClient = apiClient ?? ApiClient(),
        _sessionStorage = sessionStorage ?? SecureSessionStorage();

  final ApiClient _apiClient;
  final SecureSessionStorage _sessionStorage;

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    final response = await _apiClient.dio.post<Map<String, dynamic>>(
      '/auth/student/login',
      data: {
        'studentId': studentId,
        'password': password,
      },
    );

    final token = response.data?['accessToken'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Student login did not return an access token.');
    }

    await _sessionStorage.saveAccessToken(token);
  }
}
