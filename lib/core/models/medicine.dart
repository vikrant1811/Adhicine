import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String id;
  final String name;
  final String type;
  final int compartment;
  final DateTime startDate;
  final DateTime? endDate;
  final String frequency;
  final String time;
  final String status;

  Medicine({
    required this.id,
    required this.name,
    required this.type,
    required this.compartment,
    required this.startDate,
    this.endDate,
    required this.frequency,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'compartment': compartment,
      'startDate': startDate,
      'endDate': endDate,
      'frequency': frequency,
      'time': time,
      'status': status,
    };
  }

  static Medicine fromMap(Map<String, dynamic> map, String id) {
    return Medicine(
      id: id,
      name: map['name'],
      type: map['type'],
      compartment: map['compartment'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: map['endDate'] != null ? (map['endDate'] as Timestamp).toDate() : null,
      frequency: map['frequency'],
      time: map['time'],
      status: map['status'],
    );
  }
}