abstract class BaseResultContract<T> {
  onFailure(String error);
  onSuccess(T result);
}