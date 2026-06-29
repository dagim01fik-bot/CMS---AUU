import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/verify_student_id_response.dart';

class ScanHistoryStore {
  static const _boxName = 'scan_history';
  static const _recordsKey = 'today_records';

  Future<Box<String>> _openBox() {
    return Hive.isBoxOpen(_boxName)
        ? Future.value(Hive.box<String>(_boxName))
        : Hive.openBox<String>(_boxName);
  }

  Future<void> save(VerifyStudentIdResponse response) async {
    final box = await _openBox();
    final existing = await readToday();
    final updated = [
      TodayScanHistoryItem(
        scannedAt: DateTime.now(),
        response: response,
      ),
      ...existing,
    ];

    final encoded = jsonEncode(
      updated.map((entry) => entry.toJson()).toList(),
    );
    await box.put(_recordsKey, encoded);
  }

  Future<List<TodayScanHistoryItem>> readToday() async {
    final box = await _openBox();
    final raw = box.get(_recordsKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    final now = DateTime.now();
    final records = decoded
        .whereType<Map<String, dynamic>>()
        .map(TodayScanHistoryItem.fromJson)
        .where((entry) {
          final local = entry.scannedAt.toLocal();
          return local.year == now.year &&
              local.month == now.month &&
              local.day == now.day;
        })
        .toList()
      ..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));

    return records;
  }
}

class TodayScanHistoryItem {
  const TodayScanHistoryItem({
    required this.scannedAt,
    required this.response,
  });

  final DateTime scannedAt;
  final VerifyStudentIdResponse response;

  factory TodayScanHistoryItem.fromJson(Map<String, dynamic> json) {
    return TodayScanHistoryItem(
      scannedAt: DateTime.tryParse(json['scannedAt'] as String? ?? '') ??
          DateTime.now().toUtc(),
      response: VerifyStudentIdResponse.fromJson(
        json['response'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scannedAt': scannedAt.toUtc().toIso8601String(),
      'response': response.toJson(),
    };
  }
}
