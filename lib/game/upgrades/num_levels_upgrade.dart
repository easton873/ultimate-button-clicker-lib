import 'package:button_clicker/game/upgrades/upgrades.dart';

class NumLevelsUpgrade extends Upgrade {
  NumLevelsUpgrade() : super(BaseUpgrade(name: "Number of Unlocked Levels", maxLevel: 15));

  NumLevelsUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return NumLevelsUpgrade.fromJson(json);
  }

  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  @override
  int getCost(int level) {
    return level * 2;
  }

  int getTotalLevelsUnlocked() {
    return getTotalLevelsUnlockedByLevel(super.getLevel());
  }

  int getTotalLevelsUnlockedByLevel(int level) {
    return level * 2;
  }

  @override
  String getSpecificDescrption(int level) {
    return "${getTotalLevelsUnlockedByLevel(level)}";
  }

  @override
  String getDescription() {
    return "Number of Playable Levels";
  }
}