import '../../model/base_model.dart';
import 'package:dio/dio.dart';

class BaseApiService {
  final String collection;
  Dio dio;

  BaseApiService(String url, this.collection) {
    dio = Dio(BaseOptions(
      baseUrl: "$url/$collection",
      connectTimeout: 5000,
    ));
  }

  Future<Map<String, dynamic>> create(BaseModel item) async {
    Response response = await dio.post(
      "/",
      data: item.toMap(),
    );

    print(response.statusCode);
    print(response.statusMessage);
    print(response.data);

    if (response == null || response.statusCode != 201) {
      return null;
    }
    return item.toMap();
  }

  Future<Map<String, dynamic>> read(BaseModel item) async {
    Response response = await dio.post(
        "/${item.id}",
        data: {
          "by": "_id",
          "findOne": true,
        }
    );
    if (response == null || response.statusCode != 200) {
      return null;
    }
    return response.data as Map<String, dynamic>;
  }

  Future update(BaseModel item) async {
    Response response = await dio.put(
      "/${item.id}",
      data: item.toMap(),
    );
    if (response == null || response.statusCode != 200) {
      return null;
    }
    return item.toMap();
  }

  Future<Map<String, dynamic>> delete(BaseModel item) async {
    Response response = await dio.delete(
        "/${item.id}"
    );
    if (response == null || response.statusCode != 200) {
      return null;
    }
    return item.toMap();
  }

  Future<List<Map<String, dynamic>>> findBy(String field, value) async {
    Response response = await dio.post(
        "/$value",
        data: {
          "by": field,
        }
    );
    if (response == null || response.statusCode != 200) {
      return null;
    }
    return List.from(response.data).map<Map<String, dynamic>>((item) => item as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> list() async {
    Response response = await dio.get("/");
    if (response == null || response.statusCode != 200) {
      return null;
    }
    return List.from(response.data).map<Map<String, dynamic>>((item) => item as Map<String, dynamic>).toList();
  }

}
