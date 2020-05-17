import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

NotificationDetails get _noSound {
  final androidChannelSpecifics = AndroidNotificationDetails(
    '0',
    'Silent Notification',
    'No Sound Notification',
    playSound: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showSilentNotification(
  FlutterLocalNotificationsPlugin notifications,
  {
    @required String title,
    @required String body,
    //int id = DateTime.now().millisecondsSinceEpoch,
  }
) => _showNotification(notifications, title: title, body: body, type: _noSound);

NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'push_notification',
    'Push Notification',
    null,
    playSound: true,
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: true,
    autoCancel: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications,
  {
    @required String title,
    @required String body,
    //int id = 0,
  }
) => _showNotification(notifications, title: title, body: body, type: _ongoing);

int notificationId() {
  var date = DateTime.now();
  String id = "${date.hour}${date.minute}${date.second}";
  return int.parse(id);
}

Future _showNotification(
  FlutterLocalNotificationsPlugin notifications,
  {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    //int id = 0,
  }
) => notifications.show(notificationId(), title, body, type);
