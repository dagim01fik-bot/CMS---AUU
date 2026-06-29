class SecurityLoginRequest {
  const SecurityLoginRequest({
    required this.identifier,
    required this.password,
    required this.installationId,
  });

  final String identifier;
  final String password;
  final String installationId;

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'password': password,
      'installationId': installationId,
    };
  }
}
