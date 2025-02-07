import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/models/medicine.dart';

class MedicineList extends StatelessWidget {
  final List<Medicine> medicines;

  const MedicineList({required this.medicines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return MedicineCard(medicine: medicine);
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        // Display an initial representing the medicine type
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade300,
          child: Text(
            medicine.type.substring(0, 1),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(medicine.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${medicine.type}'),
            Text('Compartment: ${medicine.compartment}'),
            Text('Frequency: ${medicine.frequency}'),
            Text('Time: ${medicine.time}'),
            Text('Start: ${DateFormat('dd/MM/yyyy').format(medicine.startDate)}'),
            if (medicine.endDate != null)
              Text('End: ${DateFormat('dd/MM/yyyy').format(medicine.endDate!)}'),
          ],
        ),
        trailing: Chip(
          label: Text(medicine.status),
          backgroundColor: _getStatusColor(medicine.status),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
        return Colors.green;
      case 'missed':
        return Colors.red;
      case 'snoozed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
