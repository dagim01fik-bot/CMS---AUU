import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/security_login_request.dart';
import '../models/security_login_response.dart';
import '../models/verify_student_id_request.dart';
import '../models/verify_student_id_response.dart';

class SecurityApiClient {
  SecurityApiClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: ApiConstants.connectTimeout,
                receiveTimeout: ApiConstants.receiveTimeout,
                contentType: Headers.jsonContentType,
              ),
            );

  final Dio _dio;

  Future<SecurityLoginResponse> login(SecurityLoginRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/security/login',
      data: request.toJson(),
    );

    return SecurityLoginResponse.fromJson(response.data ?? const <String, dynamic>{});
  }

  Future<VerifyStudentIdResponse> verifyStudentId({
    required String accessToken,
    required VerifyStudentIdRequest request,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/verify/student-id',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    return VerifyStudentIdResponse.fromJson(
      response.data ?? const <String, dynamic>{},
    );
  }
}
