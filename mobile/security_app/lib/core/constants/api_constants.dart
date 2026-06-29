class ApiConstants {
  static const String appName = 'UniGate Security';
  static const String baseUrl = 'http://127.0.0.1:5000/api';
  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration resultDisplayDuration = Duration(seconds: 8);
  static const Duration duplicateScanThrottle = Duration(seconds: 3);
}
