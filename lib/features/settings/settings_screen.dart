import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';
import './components/settings_section.dart';
import './components/caretakers_grid.dart';
import './components/device_connection.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SettingsSection(
            title: 'Settings',
            items: [
              ListTile(title: Text('Notification'), subtitle: Text('Check your medicine notification')),
              ListTile(title: Text('Sound'), subtitle: Text('Ring, Silent, Vibrate')),
              ListTile(title: Text('Manage Your Account'), subtitle: Text('Password, Email ID , Phone Number')),
            ],
          ),
          SettingsSection(
            title: 'Device',
            items: [
              ListTile(
                title: Text('Connect'),
                subtitle: Text('Bluetooth, Wi-Fi'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DeviceConnectionScreen()),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Caretakers: 03', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          CaretakersList(),
          SettingsSection(
            title: 'Doctor',
            items: [
              ListTile(
                title: Text('Add Your Doctor'),
                trailing: Icon(Icons.add),
                onTap: () {}, // Implement doctor addition
              ),
            ],
          ),
          Divider(),
          ListTile(title: Text('Privacy Policy'), onTap: () {}),
          ListTile(title: Text('Terms of Use'), onTap: () {}),
          ListTile(title: Text('Rate Us'), onTap: () {}),
          ListTile(title: Text('Share'), onTap: () {}),
          ElevatedButton(

            onPressed: () async {
              await authService.signOut();
            },
            child: Text('Log Out'),
          ),



        ],
      ),
    );
  }
}