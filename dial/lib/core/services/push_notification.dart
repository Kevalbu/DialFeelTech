import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


late final BuildContext buildContext;

class FirebaseNotifications {
  static late FirebaseMessaging _firebaseMessaging;

  static FirebaseNotifications? _instance;

  factory FirebaseNotifications(BuildContext context) =>
      _instance ?? FirebaseNotifications._internal(context);

  FirebaseNotifications._internal(BuildContext context) {
    initialize(context);
  }

  void initialize(BuildContext context) {
    buildContext = context;
    _firebaseMessaging = FirebaseMessaging.instance;
    _NotificationHandler.initialize(buildContext);
    firebaseCloudMessagingListener();
  }

  static Future<dynamic> onBackgroundMessage(RemoteMessage message) async {
    final String daata = message.data.toString();
    final List<String> str =
    daata.replaceAll('{', '').replaceAll('}', '').split(',');
    final Map<String, dynamic> result = <String, dynamic>{};
    for (int i = 0; i < str.length; i++) {
      final List<String> s = str[i].split(':');
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    print(result);

    if (result["type"] != null) {
      // DeepLinking.GoTo(
      //     int.parse(result["type"]),
      //     int.parse(result["redirect_on"]),
      //     int.parse(result["redirect_on"]),
      //     buildContext);
    }
  }

  Future<void> firebaseCloudMessagingListener() async {
    if (Platform.isIOS) {
      _iOSPermission();
    }

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen(_onMessageListener);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// [_handleMessage] used for onCLick navigation of notification
  void _handleMessage(RemoteMessage message) {
    final String daata = message.data.toString();
    final List<String> str =
    daata.replaceAll('{', '').replaceAll('}', '').split(',');
    final Map<String, dynamic> result = <String, dynamic>{};
    for (int i = 0; i < str.length; i++) {
      final List<String> s = str[i].split(':');
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }

    if (result["type"] != null) {
      // DeepLinking.GoTo(
      //     int.parse(result["type"]),
      //     int.parse(result["redirect_on"]),
      //     int.parse(result["redirect_on"]),
      //     buildContext);
    }
  }

  static void _onMessageListener(RemoteMessage message) {
    _NotificationHandler.showNotification(message);
  }

  static Future<void> _iOSPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    _firebaseMessaging.getNotificationSettings();
  }

  static Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

class _NotificationHandler {
  static final flutterLocalNotifications = FlutterLocalNotificationsPlugin();
  static BuildContext? context;

  static Future<void> initialize(BuildContext buildContext) async {
    context = buildContext;
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotifications.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
        onDidReceiveNotificationResponse: _onSelectFrontNotification);
    if (Platform.isIOS) {
      await flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();
    } else {
      await flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
  }

  static _onSelectNotification(NotificationResponse? payload) async {
    if (payload != null) {
      final List<String> str =
      payload.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
      final Map<String, dynamic> result = <String, dynamic>{};
      for (int i = 0; i < str.length; i++) {
        final List<String> s = str[i].split(':');
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }

      if (result["type"] != null) {
        // DeepLinking.GoTo(
        //     int.parse(result["type"]),
        //     int.parse(result["redirect_on"]),
        //     int.parse(result["redirect_on"]),
        //     context);
      }
    }
  }

  static _onSelectFrontNotification(NotificationResponse? payload) async {
    if (payload != null) {
      final List<String> str =
      payload.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
      final Map<String, dynamic> result = <String, dynamic>{};
      for (int i = 0; i < str.length; i++) {
        final List<String> s = str[i].split(':');
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }
      print(result);

      if (result["type"] != null) {
        // DeepLinking.GoTo(
        //     int.parse(result["type"]),
        //     int.parse(result["redirect_on"]),
        //     int.parse(result["redirect_on"]),
        //     context);
      }
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {


    const AndroidNotificationDetails androidPlatformChannel =
    AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('lmg_sonic'),
      autoCancel: true,
      // onlyAlertOnce: true,
    );

    const NotificationDetails platformChannel = NotificationDetails(
      android: androidPlatformChannel,
    );

    await flutterLocalNotifications.show(
      message.ttl ?? 0,
      message.notification?.title,
      message.notification?.body,
      platformChannel,
      payload: message.data.toString(),
    );


  }
}

clearAllNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancelAll();
}
