// Imports Flutter
import 'package:flutter/material.dart';

// Imports Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:obus/firebase_options.dart';

// Imports External
import 'package:obus/app/funcs/notification_controller.dart';

// Imports Project
import 'package:obus/app_widget.dart';

// * App Start
void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
    // Firebase

    // Notificações
    await NotificationController.initializeLocalNotifications();
    // Notificações

    runApp(const AppWidget());
}
