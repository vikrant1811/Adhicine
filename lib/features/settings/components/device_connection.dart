import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/connectivity_service.dart';

class DeviceConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final connectivityService = Provider.of<ConnectivityService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Device Connection')),
      body: FutureBuilder<bool>(
        future: connectivityService.checkConnection(),
        builder: (context, snapshot) {
          final isConnected = snapshot.data ?? false;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Network Status'),
                  trailing: Icon(
                    isConnected ? Icons.wifi : Icons.wifi_off,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                  subtitle: Text(isConnected ? 'Connected' : 'No Connection'),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Connection Options:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SwitchListTile(
                  title: Text('Enable Wi-Fi'),
                  value: true,
                  onChanged: (value) {
                    // Implement actual Wi-Fi toggle logic
                  },
                ),
                SwitchListTile(
                  title: Text('Enable Mobile Data'),
                  value: true,
                  onChanged: (value) {
                    // Implement actual mobile data toggle logic
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}