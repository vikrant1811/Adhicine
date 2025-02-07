import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/report.dart';
import '../../../core/services/firestore_service.dart';

class ReportSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Report>(
      stream: Provider.of<FirestoreService>(context)
          .getDailyReport(DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error loading report');
        }

        final report = snapshot.data ?? Report(
          total: 0,
          taken: 0,
          missed: 0,
          snoozed: 0,
          date: DateTime.now(),
        );

        return Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          border: TableBorder.all(),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: [
                _buildHeaderCell('Total'),
                _buildHeaderCell('Taken'),
                _buildHeaderCell('Missed'),
                _buildHeaderCell('Snoozed'),
              ],
            ),
            TableRow(
              children: [
                _buildValueCell('${report.total}'),
                _buildValueCell('${report.taken}'),
                _buildValueCell('${report.missed}'),
                _buildValueCell('${report.snoozed}'),
              ],
            ),
          ],
        );
      },
    );
  }
// Keep existing _buildHeaderCell and _buildValueCell methods


  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildValueCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}