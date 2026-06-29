class VerifyStudentIdRequest {
  const VerifyStudentIdRequest({
    required this.opaqueToken,
    required this.deviceTag,
  });

  final String opaqueToken;
  final String deviceTag;

  Map<String, dynamic> toJson() {
    return {
      'opaqueToken': opaqueToken,
      'deviceTag': deviceTag,
    };
  }
}
