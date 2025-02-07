import 'package:flutter/material.dart';

class NetworkDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Expanded(
        child: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.red),
            SizedBox(width: 10),
            Text('No Internet Connection'),
          ],
        ),
      ),
      content: Text('Please check your network connection and try again.'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}