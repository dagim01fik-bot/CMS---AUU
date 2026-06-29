class VerifyStudentIdResponse {
  const VerifyStudentIdResponse({
    required this.studentName,
    required this.studentId,
    required this.program,
    required this.yearOfStudy,
    required this.enrollmentStatus,
    required this.academicYear,
    required this.photoThumbnailUrl,
    required this.verifiedAtUtc,
    required this.source,
    required this.warningMessage,
  });

  final String studentName;
  final String studentId;
  final String program;
  final int yearOfStudy;
  final String enrollmentStatus;
  final String academicYear;
  final String? photoThumbnailUrl;
  final DateTime verifiedAtUtc;
  final String source;
  final String? warningMessage;

  bool get isOffline => source == 'offline-cache';

  factory VerifyStudentIdResponse.fromJson(Map<String, dynamic> json) {
    final verifiedAtRaw = json['verifiedAtUtc'] as String?;
    return VerifyStudentIdResponse(
      studentName: json['studentName'] as String? ?? 'Unknown Student',
      studentId: json['studentId'] as String? ?? '--',
      program: json['program'] as String? ?? 'Unknown Program',
      yearOfStudy: json['yearOfStudy'] as int? ?? 0,
      enrollmentStatus: json['enrollmentStatus'] as String? ?? 'Unknown',
      academicYear: json['academicYear'] as String? ?? '--',
      photoThumbnailUrl: json['photoThumbnailUrl'] as String?,
      verifiedAtUtc: DateTime.tryParse(verifiedAtRaw ?? '') ?? DateTime.now().toUtc(),
      source: json['source'] as String? ?? 'online',
      warningMessage: json['warningMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentName': studentName,
      'studentId': studentId,
      'program': program,
      'yearOfStudy': yearOfStudy,
      'enrollmentStatus': enrollmentStatus,
      'academicYear': academicYear,
      'photoThumbnailUrl': photoThumbnailUrl,
      'verifiedAtUtc': verifiedAtUtc.toUtc().toIso8601String(),
      'source': source,
      'warningMessage': warningMessage,
    };
  }

  VerifyStudentIdResponse copyWith({
    String? source,
    String? warningMessage,
  }) {
    return VerifyStudentIdResponse(
      studentName: studentName,
      studentId: studentId,
      program: program,
      yearOfStudy: yearOfStudy,
      enrollmentStatus: enrollmentStatus,
      academicYear: academicYear,
      photoThumbnailUrl: photoThumbnailUrl,
      verifiedAtUtc: verifiedAtUtc,
      source: source ?? this.source,
      warningMessage: warningMessage ?? this.warningMessage,
    );
  }
}
