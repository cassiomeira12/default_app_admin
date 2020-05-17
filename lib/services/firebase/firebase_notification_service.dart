import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../contract/user/notification_contract.dart';
import '../../model/singleton/singleton_user.dart';
import '../../model/user_notification.dart';
import '../../services/firebase/base_firebase_service.dart';
import '../../utils/log_util.dart';
import 'package:package_info/package_info.dart';

class FirebaseNotificationService implements NotificationContractService {
  CollectionReference _collection;
  BaseFirebaseService _firebaseCrud;

  FirebaseNotificationService(String path) {
    _firebaseCrud = BaseFirebaseService("users/${SingletonUser.instance.id}/$path");
    _collection = _firebaseCrud.collection;
  }

  @override
  Future<UserNotification> create(UserNotification item) {
    return _firebaseCrud.create(item).then((response) {
      return UserNotification.fromMap(response);
    });
  }

  @override
  Future<UserNotification> read(UserNotification item) {
    return _firebaseCrud.read(item).then((response) {
      return UserNotification.fromMap(response);
    }).catchError((error) {
      Log.e("Document ${item.id} not found");
    });
  }

  @override
  Future<UserNotification> update(UserNotification item) {
    return _firebaseCrud.update(item).then((response) {
      return UserNotification.fromMap(response);
    }).catchError((error) {
      Log.e("Document ${item.id} not found");
    });
  }

  @override
  Future<UserNotification> delete(UserNotification item) {
    return _firebaseCrud.delete(item).then((response) {
      return UserNotification.fromMap(response);
    }).catchError((error) {
      Log.e("Document ${item.id} not found");
    });
  }

  @override
  Future<List<UserNotification>> findBy(String field, value) {
    return _firebaseCrud.findBy(field, value).then((response) {
      return response.map<UserNotification>((item) => UserNotification.fromMap(item)).toList();
    });
  }

  @override
  Future<List<UserNotification>> list() async {
//    return _service.list().then((response) {
//      return response.map<UserNotification>((item) => UserNotification.fromMap(item)).toList();
//    });

    List<UserNotification> list = List();

    var usersNotifications = await _collection.limit(20).getDocuments().timeout(Duration(seconds: 10)).then((value) {
      return value.documentChanges.map<UserNotification>((doc) => UserNotification.fromMap(doc.document.data)).toList();
    });
    list.addAll(usersNotifications);

    var geral = Firestore.instance.collection("notifications");

    var notificationsDestinationUser = await geral.limit(20).where("destinationUser", isEqualTo: SingletonUser.instance.id).getDocuments().then((value) {
      return value.documentChanges.map<UserNotification>((doc) => UserNotification.fromMap(doc.document.data)).toList();
    });
    list.addAll(notificationsDestinationUser);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName + "-" + Platform.operatingSystem;

    List<String> topics = ["ALL", packageName];

    for (String topic in topics) {
      var notificationsTopic = await geral.limit(20).where("topic", isEqualTo: topic).getDocuments().then((value) {
        return value.documentChanges.map<UserNotification>((doc) => UserNotification.fromMap(doc.document.data)).toList();
      });
      list.addAll(notificationsTopic);
    }

    list.sort((a, b) {
      return b.createAt.compareTo(a.createAt);
    });

    return list;
  }

}