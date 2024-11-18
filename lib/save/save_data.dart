import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/saver.dart';
import 'package:button_clicker/save/shared_prefs.dart';
import 'package:button_clicker/save/to_json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SaveData {
  late SharedPreferences _prefs;
  late Saver saveStrategy;
  final String saveKey = 'saved';
  static const String generalDataSaveKey = "generalData";

  static final SaveData _singleton = SaveData._internal();

  factory SaveData() {
    return _singleton;
  }

  SaveData._internal();

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    saveStrategy = SharedPref(_prefs);
  }

  Future<T> initData<T extends JsonUnmarshaller>(T decoder) async {
    String? key = _prefs.getString(saveKey);
    if (key == null) {
      return decoder;
    }
    return loadData(decoder, key);
  }

  void saveData(JsonMarshaller data, String key) {
    saveStrategy.saveData(data, key);
  }

  void saveGameData(JsonMarshaller data, String key) {
    saveStrategy.setString(saveKey, key); // save the latest save so when you load next time it is this one
    saveData(data, key);
  }

  String? _loadJsonData(String key) {
    return _prefs.getString(key);
  }

  T loadData<T extends JsonUnmarshaller>(T decoder, String key){
    String? jsonStr = _loadJsonData(key);
    if (jsonStr == null){
      return decoder;
    }
    return decoder.decodeJson(jsonDecode(jsonStr)); 
  }

  void wipeData(){
    _prefs.clear();
    // _prefs.remove(saveKey);
  }

  void wipeKey(String key) {
    _prefs.remove(key);
  }

  void wipeTutorialData() {
    _prefs.remove(Constants.defaultGameDataKey);
  }
}