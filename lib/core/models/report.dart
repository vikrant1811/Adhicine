import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final int total;
  final int taken;
  final int missed;
  final int snoozed;
  final DateTime date;

  Report({
    required this.total,
    required this.taken,
    required this.missed,
    required this.snoozed,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'taken': taken,
      'missed': missed,
      'snoozed': snoozed,
      'date': Timestamp.fromDate(date),
    };
  }

  static Report fromMap(Map<String, dynamic> map) {
    return Report(
      total: (map['total'] as num?)?.toInt() ?? 0,
      taken: (map['taken'] as num?)?.toInt() ?? 0,
      missed: (map['missed'] as num?)?.toInt() ?? 0,
      snoozed: (map['snoozed'] as num?)?.toInt() ?? 0,
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}