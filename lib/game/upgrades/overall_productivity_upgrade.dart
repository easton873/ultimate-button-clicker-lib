import 'dart:math';

import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class OverallProductivityUpgrade extends Upgrade {
  OverallProductivityUpgrade() : super(BaseUpgrade(name: "Overall Productivity", maxLevel: 100));

  OverallProductivityUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return OverallProductivityUpgrade.fromJson(json);
  }

  @override
  int getCost(int level) {
    return level * pow(10, 1 + ((level - 1) * .05)).toInt();
  }

  double getBoost() {
    return getBoostByLevel(super.getLevel());
  }

  double getBoostByLevel(int level) {
    // e^.2x - 1
    return pow(e, .3 * (level-1)) - 1;
  }

  @override
  String getSpecificDescrption(int level) {
    return Constants.displayPercentage(getBoostByLevel(level));
  }

  @override
  String getDescription() {
    return "Boost to Everything";
  }
}