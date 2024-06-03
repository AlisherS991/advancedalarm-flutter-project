
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:on_audio_query/on_audio_query.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    tz.initializeTimeZones();
  }

  static shechuledNotification(String channelID, String title, String body,
      String uri, int duration, int id) async {
        ;
    var androiddetails = AndroidNotificationDetails(
      channelID,
      channelID,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: uri=='frfr' ? UriAndroidNotificationSound(uri) 
       : const RawResourceAndroidNotificationSound('alarmsong'),
    );

    var notificationsdetails = NotificationDetails(android: androiddetails);
    await _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds:duration)),
        notificationsdetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle);
        
  }
  static deleteNotification(int id)  async {
    await _notification .cancel(id);
  }
  static deleteNotifications(List<int> numbers)  async {
    for(int i=0;i<numbers.length;i++){
await _notification .cancel(numbers[i]);
    }

    
    
    
  }

  // static periodicNotification(
  //     String title, String body, String uri, int length) async {
  //   var androiddetails = AndroidNotificationDetails(
  //     'channel 1',
  //     'n',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     playSound: true,
  //     sound: UriAndroidNotificationSound(uri),
  //   );
  //   var notificationsdetails = NotificationDetails(android: androiddetails);
  //   await _notification.periodicallyShow(
  //       0, title, body, RepeatInterval.everyMinute, notificationsdetails);
  // }
}
