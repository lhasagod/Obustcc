// Imports Dart
import 'dart:math';

// Imports Flutter
import 'package:flutter/material.dart';

// Imports External
import 'package:awesome_notifications/awesome_notifications.dart';

// Imports Project
import 'package:obus/app_widget.dart';
import 'package:obus/app_route.dart';


class NotificationController {

    //? Variáveis
    static ReceivedAction? initialAction;
    //? Variáveis

    //? Init
    static Future<void> initializeLocalNotifications() async {
        await AwesomeNotifications().initialize(

            // set the icon to null if you want to use the default app icon
            null, // 'resource://drawable/res_app_icon',
            [
                NotificationChannel(
                    channelGroupKey: 'basic_channel_group',
                    channelKey: 'basic_channel',
                    channelName: 'Basic notifications',
                    channelDescription: 'Notification channel basic and geral',
                    playSound: true,
                    onlyAlertOnce: false,
                    enableVibration: true,
                    groupAlertBehavior: GroupAlertBehavior.All,
                    importance: NotificationImportance.Default,
                    defaultPrivacy: NotificationPrivacy.Public,
                    defaultColor: const Color(0xFF9D50DD),
                    ledColor: Colors.white
                ),
            ],

            // Channel groups are only visual and are not required
            channelGroups: [
                NotificationChannelGroup(
                    channelGroupKey: 'basic_channel_group',
                    channelGroupName: 'Basic group'
                )
            ],

            debug: true
        );

        // Get initial notification action is optional
        initialAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
    }
    //? Init

    //? Permission
    static Future<bool> displayNotificationRationale() async {
        bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
        if (!isAllowed) { await AwesomeNotifications().requestPermissionToSendNotifications(); }
        return true;
    }
    //? Permission

    //? Listner
    ///  Notifications events are only delivered after call this method
    static Future<void> startListeningNotificationEvents() async {
        AwesomeNotifications().setListeners(
            // onNotificationCreatedMethod:    onNotificationCreatedMethod,
            // onNotificationDisplayedMethod:  onNotificationDisplayedMethod,
            // onDismissActionReceivedMethod:  onDismissActionReceivedMethod,
            onActionReceivedMethod:         onActionReceivedMethod,
        );
    }
    //? Listner

    //? Background
    static Future<void> executeLongTaskInBackground() async {
        // Your code goes here
    }
    //? Background

    //? Funções
    /// Use this method to detect when a new notification or a schedule is created
    @pragma('vm:entry-point')
    static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
        // Your code goes here
    }

    /// Use this method to detect every time that a new notification is displayed
    @pragma('vm:entry-point')
    static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
        // Your code goes here
    }

    /// Use this method to detect if the user dismissed a notification
    @pragma('vm:entry-point')
    static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
        // Your code goes here
    }

    /// Use this method to detect when the user taps on a notification or action button
    @pragma('vm:entry-point')
    static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {

        // Navigate into pages, avoiding to open the notification details page over another details page already opened
        if(
            receivedAction.actionType == ActionType.SilentAction
            || receivedAction.actionType == ActionType.SilentBackgroundAction
        ) {
            // For background actions, you must hold the execution until the end
            await executeLongTaskInBackground();
        }
        else {
            AppWidget.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                Routes.home,
                (route) => (route.settings.name != Routes.home) || route.isFirst,
                arguments: receivedAction
            );

            /*
            BuildContext? context = RouteGenerator().generateRoute.routerDelegate.navigatorKey.currentContext;
            context!.goNamed(Routes.home, extra: {'id': receivedAction});
            */
        }
    }
    //? Funções

    //? Notification
    static Future<void> createNotification({String? title, String? body}) async {

        bool isAllowed = await displayNotificationRationale();
        if (!isAllowed) return;
        int notificationId = Random(1).nextInt(10000);

        await AwesomeNotifications().createNotification(
            content: NotificationContent(

                // Config
                id: notificationId,
                channelKey: 'basic_channel',
                notificationLayout: NotificationLayout.Default,
                wakeUpScreen: true,
                // Config

                // Msg
                title: title,
                body: body,
                // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
                // largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
                //'asset://assets/images/balloons-in-sky.jpg',
                // Msg

                // Data
                payload: {'notificationId': notificationId.toString()}
                // Data

            ),
            /*
            actionButtons: [
                NotificationActionButton(
                    key: 'REDIRECT',
                    label: 'Redirect'
                ),
                NotificationActionButton(
                    key: 'REPLY',
                    label: 'Reply Message',
                    requireInputText: true,
                    actionType: ActionType.SilentAction
                ),
                NotificationActionButton(
                    key: 'DISMISS',
                    label: 'Dismiss',
                    actionType: ActionType.DismissAction,
                    isDangerousOption: true
                )
            ]
            */
        );
    }

    static Future<void> scheduleNotification({String? title, String? body, required DateTime schedule}) async {

        bool isAllowed = await displayNotificationRationale();
        if (!isAllowed) return;
        int notificationId = Random(1).nextInt(10000);

        await AwesomeNotifications().createNotification(
            content: NotificationContent(

                // Config
                id: notificationId,
                channelKey: 'basic_channel',
                notificationLayout: NotificationLayout.Default,
                wakeUpScreen: true,
                // Config

                // Msg
                title: title,
                body: body,
                // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
                // largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
                //'asset://assets/images/balloons-in-sky.jpg',
                // Msg

                // Data
                payload: {'notificationId': notificationId.toString()}
                // Data

            ),

            schedule: NotificationCalendar.fromDate(
                date: schedule
            ),
        );
    }

    static Future<void> resetBadgeCounter() async {
        await AwesomeNotifications().resetGlobalBadge();
    }

    static Future<void> cancelNotifications() async {
        await AwesomeNotifications().cancelAll();
    }
    //? Notification
}
