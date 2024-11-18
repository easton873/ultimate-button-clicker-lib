abstract class JsonUnmarshaller<T> {
  T decodeJson(Map<String, dynamic> json);
}