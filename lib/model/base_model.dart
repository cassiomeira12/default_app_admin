abstract class BaseModel<T> {
  String id;
  update(T item);
  Map<String, dynamic> toMap();
}