import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class RewardUpgrade extends Upgrade {
  RewardUpgrade() : super(BaseUpgrade(name: "Reward Multiplier", maxLevel: 10));

  RewardUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return RewardUpgrade.fromJson(json);
  }

  @override
  int getCost(int level) {
    return 10 * pow(2, level).toInt();
  }

  int getMultiplier() {
    return getMultiplierByLevel(super.getLevel());
  }

  int getMultiplierByLevel(int level) {
    return pow(2, level - 1).toInt();
  }

  @override
  String getSpecificDescrption(int level) {
    return "X${getMultiplierByLevel(level)}";
  }

  @override
  String getDescription() {
    return "Level Reward Multiplier";
  }
}