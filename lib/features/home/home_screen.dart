import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/medicine.dart';
import '../../core/services/firestore_service.dart';
import '../../core/services/connectivity_service.dart'; // Add this import
import '../add_medicine/add_medicine_screen.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import '../report/report_screen.dart';
import '../settings/settings_screen.dart';
import '../widgets/network_dialog.dart'; // Add this import
import 'medicine_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ReportScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectivityService = Provider.of<ConnectivityService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<bool>(
        stream: connectivityService.connectionStatus,
        builder: (context, snapshot) {
          final isConnected = snapshot.data ?? true;

          // Show NetworkDialog if there's no internet connection
          if (!isConnected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false, // Prevent closing by tapping outside
                builder: (_) => NetworkDialog(),
              );
            });
          }

          return Column(
            children: [
              SizedBox(height: 20),
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Harry!',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'medicine left',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                actions: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: IconButton(
                      icon: Icon(Icons.medical_services, size: 25, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        child: Image.asset("assets/images/profile.png"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<List<Medicine>>(
                  stream: Provider.of<FirestoreService>(context).getMedicines(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final medicines = snapshot.data ?? [];
                    if (medicines.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/emptybox.png',
                              width: 200,
                              height: 200,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No medicines found. Add one!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }
                    return MedicineList(medicines: medicines);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: 35),
        onPressed: () async {
          final isConnected = await connectivityService.checkConnection();
          if (!isConnected) {
            showDialog(
              context: context,
              builder: (_) => NetworkDialog(),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMedicineScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}