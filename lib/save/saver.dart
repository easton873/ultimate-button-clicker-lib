import 'package:button_clicker/save/to_json.dart';

abstract class Saver {
  saveData(JsonMarshaller data, String key);
  setString(String key, String value);
}