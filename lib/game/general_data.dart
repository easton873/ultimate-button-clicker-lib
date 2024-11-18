
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/to_json.dart';

class GeneralData implements JsonUnmarshaller<GeneralData>, JsonMarshaller{
  bool purchased = false;
  Set<String> unlockedThings = <String>{Constants.defaultGameDataKey};
  final Set<String> _completedLevels = {};
  bool tutorialCompleted = false;
  int _xp = 1;

  static const String generalDataPurchased = "purchased";
  static const String generalDataUnlocked = "unlocked";
  static const String generalDataUnlockPoints = "points";
  static const String generalDataTutorialCompleted = "tutorialCompleted";
  static const String generalDataCompletedLevels = "completedLevels";
  static const String jsonXP = "xp";

  GeneralData();
  
  @override
  GeneralData decodeJson(Map<String, dynamic> json) {
    return GeneralData.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return toJson();
  }

  Map<String, dynamic> toJson() => {
    generalDataPurchased: purchased,
    generalDataUnlocked: unlockedThings.toList(),
    generalDataTutorialCompleted: tutorialCompleted,
    generalDataCompletedLevels: _completedLevels.toList(),
    jsonXP: _xp
  };

  GeneralData.fromJson(Map<String, dynamic> json) : 
  purchased = json[generalDataPurchased],
  tutorialCompleted = json[generalDataTutorialCompleted],
  _xp = json[jsonXP] ?? 0 {
    for (dynamic d in json[generalDataUnlocked]) {
      unlockedThings.add(d as String);
    }
    for (dynamic d in json[generalDataCompletedLevels]) {
      _completedLevels.add(d as String);
    }
  }

  bool isUnlocked(String key) {
    return unlockedThings.contains(key);
  }

  void unlock(String key) {
    unlockedThings.add(key);
  }

  void completeTutorial() {
    tutorialCompleted = true;
  }

  void completeLevel(GameData data) {
    addXP(data.reward);
    if (_completedLevels.contains(data.saveKey)) {
      return;
    }
    _completedLevels.add(data.saveKey);
  }

  bool isLevelCompleted(String level) {
    return _completedLevels.contains(level);
  }

  void refund(String key) {
    unlockedThings.remove(key);
  }

  int getXP() {
    return _xp;
  }

  spendXP(int amount) {
    _xp -= amount;
  }

  addXP(int amount) {
    _xp += amount;
  }

  int diffUnlockedLevelsAndCompletedLevels() {
    return unlockedThings.length - _completedLevels.length;
  }
}