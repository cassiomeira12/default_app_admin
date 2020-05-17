import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/base_model.dart';

class BaseFirebaseService {
  CollectionReference collection;
  static const int _TIMEOUT = 10;

  BaseFirebaseService(String path) {
    collection = Firestore.instance.collection(path);
  }

  Future<Map<String, dynamic>> create(BaseModel item) {
    String id = collection.document().documentID;
    if (item.id == null) item.id = id;
    return collection.document(item.id)
        .setData(item.toMap())
        .timeout(Duration(seconds: _TIMEOUT))
        .then((response) {
          return item.toMap();
    });
  }

  Future<Map<String, dynamic>> read(BaseModel item) {
    if (item.id == null) return null;
    return collection.document(item.id)
        .get()
        .timeout(Duration(seconds: _TIMEOUT))
        .then((response) {
      return response.data;
    });
  }

  Future<Map<String, dynamic>> update(BaseModel item) {
    if (item.id == null) return null;
    return collection.document(item.id)
        .updateData(item.toMap())
        .timeout(Duration(seconds: _TIMEOUT))
        .then((response) {
      return item.toMap();
    });
  }

  Future<Map<String, dynamic>> delete(BaseModel item) async {
    if (item.id == null) return null;
    var data = await read(item);
    if (data == null) return null;
    return collection.document(item.id)
        .delete()
        .timeout(Duration(seconds: _TIMEOUT))
        .then((response) {
          return data;
    });
  }

  Future<List<Map<String, dynamic>>> findBy(String field, value) {
    return collection.where(field, isEqualTo: value)
        .getDocuments()
        .timeout(Duration(seconds: _TIMEOUT))
        .then((snapshot) {
          return snapshot.documents.map<Map<String, dynamic>>((item) => item.data).toList();
    });
  }

  Future<List<Map<String, dynamic>>> list() {
    return collection.getDocuments()
        .timeout(Duration(seconds: _TIMEOUT))
        .then((snapshot) {
          return snapshot.documents.map<Map<String, dynamic>>((item) => item.data).toList();
    });
  }

}