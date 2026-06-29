import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/verify_student_id_response.dart';

class ScanCacheStore {
  static const _boxName = 'scan_cache';

  Future<Box<String>> _openBox() {
    return Hive.isBoxOpen(_boxName)
        ? Future.value(Hive.box<String>(_boxName))
        : Hive.openBox<String>(_boxName);
  }

  String createCacheKey(String opaqueToken) {
    return sha256.convert(utf8.encode(opaqueToken)).toString();
  }

  Future<void> save({
    required String opaqueToken,
    required String deviceTag,
    required VerifyStudentIdResponse response,
  }) async {
    final box = await _openBox();
    final payload = {
      'deviceTag': deviceTag,
      'response': response.toJson(),
    };
    await box.put(createCacheKey(opaqueToken), jsonEncode(payload));
  }

  Future<VerifyStudentIdResponse?> read({
    required String opaqueToken,
    required String deviceTag,
  }) async {
    final box = await _openBox();
    final raw = box.get(createCacheKey(opaqueToken));
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    if (decoded['deviceTag'] != deviceTag) {
      return null;
    }

    final response = VerifyStudentIdResponse.fromJson(
      decoded['response'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

    final now = DateTime.now();
    final verifiedAtLocal = response.verifiedAtUtc.toLocal();
    final isSameDay = now.year == verifiedAtLocal.year &&
        now.month == verifiedAtLocal.month &&
        now.day == verifiedAtLocal.day;
    if (!isSameDay) {
      return null;
    }

    return response.copyWith(
      source: 'offline-cache',
      warningMessage: 'OFFLINE — VERIFY MANUALLY',
    );
  }
}
