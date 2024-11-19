import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class RewardUpgrade extends Upgrade {
  RewardUpgrade() : super(BaseUpgrade("Reward Multiplier", 10));

  RewardUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return RewardUpgrade.fromJson(json);
  }

  @override
  int increaseCost() {
    return pow(10, super.getLevel()).toInt();
  }

  int getMultiplier() {
    return super.getLevel();
  }
}