import 'dart:convert';
import 'dart:developer';

import 'package:app_cudan/generated/intl/messages_en.dart';
import 'package:app_cudan/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/notification/notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

void handleMesage(RemoteMessage? message) {
  if (message == null) return;

  navigatorKey.currentState!
      .pushNamed(NotificationScreen.routeName, arguments: message);
}

final _localNotifications = FlutterLocalNotificationsPlugin();

callbalck(notification) {
  final message = RemoteMessage.fromMap(jsonDecode(notification.payload ?? ''));
  handleMesage(message);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    "high_importantce_notification",
    description: "this chanel is used for important notification",
    importance: Importance.defaultImportance,
  );

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMesage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMesage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/ic_launcher",
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future initLocalNotifications() async {
    var iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    var settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: callbalck,
      onDidReceiveBackgroundNotificationResponse: callbalck,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log('Token: $fCMToken');
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    initLocalNotifications();
  }
}