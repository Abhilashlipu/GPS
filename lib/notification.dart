import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationService {
  static final NotificationService _notificationService =
      NotificationService.internal();

  factory NotificationService() {
    return _notificationService;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationService.internal();

  Future<void> initNotification() async {

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<Void?>showNotification(int id,String title,String body,int seconds)async{
      
      await flutterLocalNotificationsPlugin.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android:AndroidNotificationDetails(
        'main_channel',
        'main channel',
        
        importance: Importance.max,
        priority: Priority.max,
        icon:'drawable/ic_launcher'

        ),

      ),
      
       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

       androidAllowWhileIdle: true);

  }
}
