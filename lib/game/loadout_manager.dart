import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game_data.dart';

class LoadoutManager {
  static String defaultDataKey = Constants.defaultGameDataKey;
  static Map<String, GameData> loadouts = {};

  LoadoutManager.fromJson(List<dynamic> json) {
    for (Map<String, dynamic> m in json) {
      loadouts[m[Constants.gameDataName]] = GameData.fromJson(m);
    }
  }

  static GameData getDefaultGameData() {
    GameData? data = loadouts[defaultDataKey];
    if (data == null) {
      throw Exception("Loadouts haven't been loaded yet :(");
    }
    return data;
  }
}