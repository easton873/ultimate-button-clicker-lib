import 'package:button_clicker/game/upgrades/upgrades.dart';

class NumLevelsUpgrade extends Upgrade {
  NumLevelsUpgrade() : super(BaseUpgrade("Number of Unlocked Levels", 2));

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
  int increaseCost() {
    return super.getLevel() * 2;
  }

  int getTotalLevelsUnlocked() {
    return super.getLevel() + 1;
  }
}