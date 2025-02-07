import 'package:adhicine/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/firestore_service.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import './components/report_summary.dart';
import './components/medicine_timeline.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Report',style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Report", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 16),
            ReportSummary(),
            Divider(),
            Text("Check History", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 16),
            _buildCalendarTable(),
            Divider(),
            StreamBuilder(
              stream: firestoreService.getMedicines(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return MedicineTimeline(medicines: snapshot.data!);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCalendarTable() {
    return Table(
      children: [
        TableRow(
          children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI']
              .map((day) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(day, textAlign: TextAlign.center),
          ))
              .toList(),
        ),
        TableRow(
          children: List.generate(6, (index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('${index + 1}', textAlign: TextAlign.center),
          )),
        )
      ],
    );
  }
}