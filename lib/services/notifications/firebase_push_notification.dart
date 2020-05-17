import 'dart:convert';
import 'dart:io';

import '../../model/singleton/singleton_user.dart';
import '../../services/notifications/local_notifications.dart';
import '../../utils/preferences_util.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  final notifications = FlutterLocalNotificationsPlugin();

  FirebaseNotifications() {
    var settingsAndroid = AndroidInitializationSettings("ic_stat_notification");
    var settingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload)
    );
    notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS), onSelectNotification: onSelectNotification
    );
    subscribeDefaultTopics();
  }

  void subscribeDefaultTopics() async {
    var topics = Topics.values.map<String>((t) {
      return t.toString().split('.').last;
    }).toList();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName + "-" + Platform.operatingSystem;
    topics.add(packageName);
    subscriveTopicsList(topics);
  }

  static void subscriveTopicsList(List<String> topics) async  {
    var preferences = await PreferencesUtil.getInstance();
    topics.forEach((topic) async {
      if (preferences.getString(topic) == null) {
        bool value = await subscribeToTopic(topic);
        if (value) {
          preferences.setString(topic, topic);
          print("subscriveTopic: $topic");
        }
      }
    });
  }

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      PreferencesUtil.setNotificationToken(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        pushNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch $message");
      },
    );
  }

  Future onSelectNotification(String payload) async {
    print("onSelectNotification $payload");
    //await Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(payload: payload));
  }

  void pushNotification(Map<String, dynamic> message) {
    print("onMessage $message");
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      print(data);
    }
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      String title = notification["title"];
      String body = notification["body"];

      print(title);
      print(body);

      var user = SingletonUser.instance;
      if (user != null && user.notificationToken != null && user.notificationToken.active) {
        showSilentNotification(notifications, title: title, body: body);
        //showOngoingNotification(notifications, title: title, body: body);
      }
    }
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  static Future<int> sendNotification(String title, String message, String token, String topic) async {
    String serverToken = "AAAAWQPCwag:APA91bHIiaTWTTDxL0JMDhblA7du3MNcH-izSvMF20YrpeGiuWsWxzN_SBZe3zc9_1VnNJTFc3BBh50I93uRGNB6toeY4z2O0CHZjgT2YFbvC9UK_TfVgjpF5BJpdsVlP3Wjuf4wyQU-";

    var dio = Dio(BaseOptions(
        baseUrl: "https://fcm.googleapis.com/fcm/send",
        connectTimeout: 5000,
        headers: <String, String> {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        }
    ));

    Response response = await dio.post(
      "",
      data: jsonEncode(
          <String, dynamic> {
            'notification': <String, dynamic> {
              'image': null,
              'title': title,
              'body': message,
            },
            'priority': 'high',
            'data': <String, dynamic> {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': token == null ? '/topics/$topic' : token,
          }
      ),
    );

    return response.statusCode;
  }
  
  static Future<bool> subscribeToTopic(String topic) async {
    var firebaseMessaging = FirebaseMessaging();
    return await firebaseMessaging.subscribeToTopic(topic).then((value) {
      return true;
    }).catchError((error) {
      print(error.message);
      return false;
    });
  }

  static Future<bool> unsubscribeFromTopic(String topic) async {
    var firebaseMessaging = FirebaseMessaging();
    return await firebaseMessaging.unsubscribeFromTopic(topic).then((value) {
      return true;
    }).catchError((error) {
      print(error.message);
      return false;
    });
  }

}

enum Topics {
  ALL,
}