import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/models/security_login_response.dart';

class SecureSessionStorage {
  SecureSessionStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _installationIdKey = 'installation_id';
  static const _accessTokenKey = 'access_token';
  static const _officerNameKey = 'officer_name';
  static const _officerBadgeKey = 'officer_badge';
  static const _deviceTagKey = 'device_tag';
  static const _checkpointNameKey = 'checkpoint_name';

  final FlutterSecureStorage _storage;

  Future<String> getOrCreateInstallationId() async {
    final existing = await _storage.read(key: _installationIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final random = Random.secure();
    final next = StringBuffer(DateTime.now().millisecondsSinceEpoch.toString());
    for (var index = 0; index < 4; index++) {
      next.write(random.nextInt(1 << 16).toRadixString(16).padLeft(4, '0'));
    }

    final generated = next.toString();
    await _storage.write(key: _installationIdKey, value: generated);
    return generated;
  }

  Future<void> saveSession(SecurityLoginResponse response) async {
    await _storage.write(key: _accessTokenKey, value: response.accessToken);
    await _storage.write(key: _officerNameKey, value: response.officer.fullName);
    await _storage.write(key: _officerBadgeKey, value: response.officer.badgeNumber);
    await _storage.write(key: _deviceTagKey, value: response.checkpoint.deviceTag);
    await _storage.write(key: _checkpointNameKey, value: response.checkpoint.name);
  }

  Future<StoredSession?> readSession() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final officerName = await _storage.read(key: _officerNameKey);
    final officerBadge = await _storage.read(key: _officerBadgeKey);
    final deviceTag = await _storage.read(key: _deviceTagKey);
    final checkpointName = await _storage.read(key: _checkpointNameKey);

    if ([accessToken, officerName, officerBadge, deviceTag, checkpointName]
        .any((value) => value == null || value.isEmpty)) {
      return null;
    }

    return StoredSession(
      accessToken: accessToken!,
      officerName: officerName!,
      officerBadge: officerBadge!,
      deviceTag: deviceTag!,
      checkpointName: checkpointName!,
    );
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _officerNameKey);
    await _storage.delete(key: _officerBadgeKey);
    await _storage.delete(key: _deviceTagKey);
    await _storage.delete(key: _checkpointNameKey);
  }
}

class StoredSession {
  const StoredSession({
    required this.accessToken,
    required this.officerName,
    required this.officerBadge,
    required this.deviceTag,
    required this.checkpointName,
  });

  final String accessToken;
  final String officerName;
  final String officerBadge;
  final String deviceTag;
  final String checkpointName;
}
