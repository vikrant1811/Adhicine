import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _fcm.requestPermission();
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("Received message: ${message.notification?.title}");
    // Implement local notification display
  }

  Future<String?> getDeviceToken() async {
    return await _fcm.getToken();
  }
}