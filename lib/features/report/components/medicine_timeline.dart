import 'package:flutter/material.dart';
import '../../../core/models/medicine.dart';

class MedicineTimeline extends StatelessWidget {
  final List<Medicine> medicines;

  const MedicineTimeline({required this.medicines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeSection('Morning 08:00 am', medicines),
        _buildTimeSection('Afternoon 02:00 pm', medicines),
        _buildTimeSection('Night 09:00 pm', medicines),
      ],
    );
  }

  Widget _buildTimeSection(String time, List<Medicine> medicines) {
    final filtered = medicines.where((m) => m.time == time).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(time, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        ),
        ...filtered.map((medicine) => ListTile(
          title: Text(medicine.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${medicine.type}'),
              Text('Compartment: ${medicine.compartment}'),
              Text('Frequency: ${medicine.frequency}'),
            ],
          ),
          trailing: Chip(
            label: Text(medicine.status),
            backgroundColor: _getStatusColor(medicine.status),
          ),
        )).toList(),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'taken': return Colors.green;
      case 'missed': return Colors.red;
      case 'snoozed': return Colors.orange;
      default: return Colors.grey;
    }
  }
}