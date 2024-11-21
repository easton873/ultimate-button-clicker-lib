import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class RewardUpgrade extends Upgrade {
  RewardUpgrade() : super(BaseUpgrade(name: "Reward Multiplier"));

  RewardUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return RewardUpgrade.fromJson(json);
  }

  @override
  int getCost() {
    return pow(10, super.getLevel()).toInt();
  }

  int getMultiplier() {
    return pow(2, super.getLevel() - 1).toInt();
  }
}