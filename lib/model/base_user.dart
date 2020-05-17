import '../model/status.dart';
import 'base_model.dart';
import 'phone_number.dart';

class BaseUser extends BaseModel<BaseUser> {
  NotificationToken notificationToken;
  String avatarURL;
  Status status;
  String name;
  String email;
  bool emailVerified;
  String password;
  DateTime createAt;
  DateTime updateAt;
  PhoneNumber phoneNumber;

  BaseUser();

  BaseUser.fromMap(Map<dynamic, dynamic>  map) {
    id = map["_id"];
    notificationToken = map["notificationToken"] == null ? null : NotificationToken.fromMap(map["notificationToken"]);
    avatarURL = map["avatarURL"];
    name = map["name"];
    email = map["email"];
    emailVerified = map["emailVerified"];
    password = map["password"];
    createAt = map["createAt"] == null ? null : DateTime.parse(map["createAt"]);
    updateAt = map["updateAt"] == null ? null : DateTime.parse(map["updateAt"]);
    phoneNumber = map["phoneNumber"] == null ? null : PhoneNumber.fromMap(map["phoneNumber"]);
  }

  update(BaseUser user) {
    id = user.id;
    notificationToken = user.notificationToken;
    avatarURL = user.avatarURL;
    status = user.status;
    name = user.name;
    email = user.email;
    emailVerified = user.emailVerified;
    password = user.password;
    createAt = user.createAt;
    updateAt = user.updateAt;
    phoneNumber = user.phoneNumber;
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["_id"] = id;
    map["notificationToken"] = notificationToken == null ? null : notificationToken.toMap();
    map["avatarURL"] = avatarURL;
    map["name"] = name;
    map["email"] = email;
    map["emailVerified"] = emailVerified;
    map["password"] = password;
    map["createAt"] = createAt == null ? null : createAt.toString();
    map["updateAt"] = updateAt == null ? null : updateAt.toString();
    map["phoneNumber"] = phoneNumber == null ? null : phoneNumber.toMap();
    return map;
  }

}

class NotificationToken {
  String token;
  bool active;
  List<String> topics;

  NotificationToken(this.token) {
    active = true;
  }

  NotificationToken.fromMap(Map<dynamic, dynamic> map) {
    token = map["token"];
    active = map["active"] as bool;
    //topics = List.from(map["topics"]);
  }

  toMap() {
    var map = new Map<String, dynamic>();
    map["token"] = token;
    map["active"] = active;
    //map["topics"] = topics.toString();
    return map;
  }
}