// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_cudan/screens/splash/splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:app_cudan/main.dart';
import 'package:graphql/client.dart';
import '../models/response.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/notification/prv/undread_noti.dart';
import 'api_service.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

void handleMesage(RemoteMessage? message) {
  print('handle message');
  if (message == null) return;
  UnreadNotification.getUnReadNotification();
  navigatorKey.currentState!
      .pushNamed(SplashScreen.routeName, arguments: {"message": message});
}

final _localNotifications = FlutterLocalNotificationsPlugin();

listtenCallback(notification) {
  print("callback");
  final message = RemoteMessage.fromMap(jsonDecode(notification.payload ?? ''));
  handleMesage(message);
}

final _androidChannel = const AndroidNotificationChannel(
  'high_importance_channel',
  "high_importantce_notification",
  description: "this chanel is used for important notification",
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
  showBadge: true,
  enableLights: true,
);

listen(message) {
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
        icon: "@mipmap/ic_launcher",
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    payload: jsonEncode(message.toMap()),
  );
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? fCMToken;
  Map<String, dynamic>? device_info;
  String uniqueDeviceId = '';

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMesage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMesage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(listen);
  }

  void onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {}
  Future initLocalNotifications() async {
    var iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        print('onDidReceiveLocalNotification');
      },
    );
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    var settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: listtenCallback,
      onDidReceiveBackgroundNotificationResponse: listtenCallback,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<String?> initNotification() async {
    await _firebaseMessaging.requestPermission();
    fCMToken = await _firebaseMessaging.getToken();
    log('Token: $fCMToken');

    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    initLocalNotifications();
    return fCMToken;
  }

  Future push_device(String account) async {
    await getUniqueDeviceId();
    print(device_info);
    var query = '''
mutation (\$data: PushDeviceInput){
	response:reg_push_device (data:\$data){
		code
		message
	}
}

    ''';
    print(query);
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "data": {
          "tokenId": fCMToken,
          "deviceId": uniqueDeviceId,
          "userId": account,
          "platform": Platform.isAndroid ? "ANDROID" : "IOS",
          "appId": "demepro",
          "device_info": device_info,
          "extra_info": {},
        }
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  Future<String> getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      device_info = iosDeviceInfo.data;
      uniqueDeviceId =
          '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      device_info = androidDeviceInfo.data;
      uniqueDeviceId =
          '${androidDeviceInfo.device}:${androidDeviceInfo.id}'; // unique ID  on Android
    }

    return uniqueDeviceId;
  }
}
