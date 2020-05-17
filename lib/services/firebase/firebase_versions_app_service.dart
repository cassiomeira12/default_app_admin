import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/version_app.dart';
import '../../utils/log_util.dart';

class FirebaseVersionsAppService {
  CollectionReference _collection = Firestore.instance.collection("versions");

  Future<VersionApp> checkCurrentVersion(String packageName) {
    return _collection.document(packageName).get().timeout(Duration(seconds: 5)).then((result) {
      if (!result.exists) {
        return null;
      }
      return VersionApp.fromMap(result.data);
    }).catchError((error) {
      Log.e(error);
      return null;
    });
  }

}