
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/to_json.dart';

class GeneralData implements JsonUnmarshaller<GeneralData>, JsonMarshaller{
  static const String generalDataPurchased = "purchased";
  static const String generalDataUnlocked = "unlocked";
  static const String generalDataUnlockPoints = "points";
  static const String generalDataTutorialCompleted = "tutorialCompleted";
  static const String generalDataCompletedLevels = "completedLevels";
  static const String jsonXP = "xp";
  static const String jsonTotalXP = "totalXP";

  static const int startingXP = 1;

  bool purchased = false;
  Set<String> unlockedThings = <String>{Constants.defaultGameDataKey};
  final Set<String> _completedLevels = {};
  bool tutorialCompleted = false;
  int _xp = startingXP;
  int _totalSpentXP = startingXP;

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
    jsonXP: _xp,
    jsonTotalXP: _totalSpentXP,
  };

  GeneralData.fromJson(Map<String, dynamic> json) : 
  purchased = json[generalDataPurchased],
  tutorialCompleted = json[generalDataTutorialCompleted],
  _xp = json[jsonXP] ?? startingXP,
  _totalSpentXP = json[jsonTotalXP] ?? startingXP {
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
    addXP(data.getReward());
    if (_completedLevels.contains(data.saveKey)) {
      return;
    }
    _completedLevels.add(data.saveKey);
  }

  bool isLevelCompleted(String level) {
    return _completedLevels.contains(level);
  }

  void refundLevel(String key) {
    unlockedThings.remove(key);
  }

  int getXP() {
    return _xp;
  }

  int get totalSpentXP {
    return _totalSpentXP;
  }

  spendXP(int amount) {
    _xp -= amount;
  }

  addXP(int amount) {
    _xp += amount;
    _totalSpentXP += amount;
  }

  void refundXP() {
    _xp = _totalSpentXP;
  }

  int diffUnlockedLevelsAndCompletedLevels() {
    return unlockedThings.length - _completedLevels.length;
  }
}