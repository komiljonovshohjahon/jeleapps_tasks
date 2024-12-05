import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jeleapps_tasks/main.dart';
import 'package:jeleapps_tasks/presentation/components/dialogs/error.dart';

class HomePageVm extends ChangeNotifier {
  String fcmToken = '';

  Future<void> requestPermission(BuildContext context) async {
    try {
      await FirebaseMessaging.instance.requestPermission(provisional: true);
    } catch (e) {
      if (context.mounted) ErrorDialog.show(context, e.toString());
    }
  }

  Future<void> getToken(BuildContext context) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        fcmToken = token;
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) ErrorDialog.show(context, e.toString());
    }
  }

  void listenNotifications() {
    FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (message.notification != null) {
      return plugin.show(
          0,
          message.notification!.title ?? "Title",
          message.notification!.body ?? "Body",
          const NotificationDetails(
              android: AndroidNotificationDetails(
            'jeleapps_task',
            'JeleApps Task',
            priority: Priority.high,
            importance: Importance.max,
          )));
    }
  }
}
