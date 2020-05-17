import '../../contract/user/notification_contract.dart';
import '../../model/user_notification.dart';
import '../../services/firebase/firebase_notification_service.dart';

class NotificationPresenter extends NotificationContractPresenter {
  NotificationContractService service;

  NotificationPresenter(NotificationContractView view) : super(view) {
    service = FirebaseNotificationService("notifications");
  }

  @override
  Future<UserNotification> create(UserNotification item) {
    return service.create(item);
  }

  @override
  Future<UserNotification> read(UserNotification item) {
    return service.read(item);
  }

  @override
  Future<UserNotification> update(UserNotification item) {
    return service.update(item);
  }

  @override
  Future<UserNotification> delete(UserNotification item) {
    return service.delete(item);
  }

  @override
  Future<List<UserNotification>> findBy(String field, value) {
    return service.findBy(field, value);
  }

  @override
  Future<List<UserNotification>> list() async {
    await service.list().then((value) {
      if (view != null) {
        view.listNotifications(value);
      }
    }).catchError((error) {
      if (view != null) {
        view.onFailure(error.message);
      }
    });
  }

}