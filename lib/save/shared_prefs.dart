import 'dart:convert';

import 'package:button_clicker/save/saver.dart';
import 'package:button_clicker/save/to_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref implements Saver {
  SharedPreferences _prefs;

  SharedPref(this._prefs);

  @override
  saveData(JsonMarshaller data, String key) {
    final String jsonStr = jsonEncode(data.encodeJson());
    _prefs.setString(key, jsonStr);
  }
  
  @override
  setString(String key, String value) {
    _prefs.setString(key, value);
  }

}