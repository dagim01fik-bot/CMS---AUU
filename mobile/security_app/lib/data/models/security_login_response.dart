class SecurityLoginResponse {
  const SecurityLoginResponse({
    required this.accessToken,
    required this.role,
    required this.officer,
    required this.checkpoint,
  });

  final String accessToken;
  final String role;
  final OfficerProfile officer;
  final CheckpointAssignment checkpoint;

  factory SecurityLoginResponse.fromJson(Map<String, dynamic> json) {
    return SecurityLoginResponse(
      accessToken: json['accessToken'] as String? ?? '',
      role: json['role'] as String? ?? 'security_officer',
      officer: OfficerProfile.fromJson(
        json['officer'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      ),
      checkpoint: CheckpointAssignment.fromJson(
        json['checkpoint'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      ),
    );
  }
}

class OfficerProfile {
  const OfficerProfile({
    required this.id,
    required this.fullName,
    required this.badgeNumber,
  });

  final String id;
  final String fullName;
  final String badgeNumber;

  factory OfficerProfile.fromJson(Map<String, dynamic> json) {
    return OfficerProfile(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? 'Security Officer',
      badgeNumber: json['badgeNumber'] as String? ?? '',
    );
  }
}

class CheckpointAssignment {
  const CheckpointAssignment({
    required this.deviceTag,
    required this.name,
  });

  final String deviceTag;
  final String name;

  factory CheckpointAssignment.fromJson(Map<String, dynamic> json) {
    return CheckpointAssignment(
      deviceTag: json['deviceTag'] as String? ?? '',
      name: json['name'] as String? ?? 'Unassigned checkpoint',
    );
  }
}
