import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/utils/navigation_helper.dart';

class NotificationHelper {
  static NotificationHelper? _instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        var data = Restaurant.fromRawJson(payload.payload ?? '');
        NavigationHelper.intentWithData(MyPaths.detail, {
          'id': data.id,
          'pic': data.pictureId,
        });
      },
    );
  }

  Future<void> showNotification(
    Restaurant data,
  ) async {
    final response = await http.get(
      Uri.parse(ApiConst.mediumPic(data.pictureId ?? '')),
    );

    var bigPictureStyleInformation = BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(response.bodyBytes),
      ),
    );

    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'dicoding restaurant';

    var androidPlatfromChannelSpesifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: bigPictureStyleInformation,
    );

    var iOSPlatfromChannelSpesifics = const DarwinNotificationDetails();
    var platfromChannelSpesifics = NotificationDetails(
      android: androidPlatfromChannelSpesifics,
      iOS: iOSPlatfromChannelSpesifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Rekomendasi restaurant hanya untuk mu :)',
      data.name ?? 'Nama restaurant',
      platfromChannelSpesifics,
      payload: jsonEncode(data.toJson()),
    );
  }
}
