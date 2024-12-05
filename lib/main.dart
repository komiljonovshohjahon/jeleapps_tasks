import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jeleapps_tasks/firebase_options.dart';
import 'package:jeleapps_tasks/presentation/views/homepage/home_page.dart';

FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await plugin.initialize(initializationSettings);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const JeleAppsApp());
}

class JeleAppsApp extends StatelessWidget {
  const JeleAppsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JeleApps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
