import 'package:flutter/material.dart';

class NetworkDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off, color: Colors.red),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              'No Internet Connection',
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Text('Please check your network connection and try again.'),
      ),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(20), // Add padding
    );
  }
}