// Imports Flutter
import 'package:flutter/material.dart';

// Imports External
import 'package:obus/app/funcs/notification_controller.dart';

// Imports Project
import 'package:obus/app_route.dart';

// * App First Screen
class AppWidget extends StatelessWidget {
    const AppWidget({ Key? key }) : super(key: key);

    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    @override
    Widget build(BuildContext context) {

        // Notificações
        // Only after at least the action method is set, the notification events are delivered
        () async {
            await NotificationController.startListeningNotificationEvents();
        }();
        // Notificações

        return MaterialApp.router(
            restorationScopeId: AppWidget.navigatorKey.toString(),
            debugShowCheckedModeBanner: true,
            title: 'Obus',
            routeInformationParser: RouteGenerator().generateRoute.routeInformationParser,
            routerDelegate: RouteGenerator().generateRoute.routerDelegate,
        );

    }
}
