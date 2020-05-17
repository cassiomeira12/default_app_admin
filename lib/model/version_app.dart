class VersionApp {
  String name;
  int currentCode;
  int minimumCode;
  String url;

  VersionApp.fromMap(Map<dynamic, dynamic> map) {
    name = map["name"];
    currentCode = map["currentCode"];
    minimumCode = map["minimumCode"];
    url = map["url"];
  }

  toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["currentCode"] = currentCode;
    map["minimumCode"] = minimumCode;
    map["url"] = url;
    return map;
  }

}