import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();
  static const _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
    ),
  );

  // final StreamController<String?> onNotification = StreamController<String?>.broadcast();

  static Future init({bool initScheduled = false}) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    if (initScheduled) {
      tz.initializeTimeZones();
    }
    await _notification.initialize(
      settings,
    );
  }

  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        _notificationDetails,
        payload: payload,
      );

  static Future<void> showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledTime,
  }) async =>
      _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static Future<void> stopAllNotifications() async {
    await _notification.cancelAll();
  }

  static Future<void> stopNotifications(int id) async {
    await _notification.cancel(id);
  }
}
