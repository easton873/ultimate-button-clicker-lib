import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class BonusBoostUpgrade extends Upgrade {
  BonusBoostUpgrade() : super(BaseUpgrade(name: "Boost Bonus"));

  BonusBoostUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return BonusBoostUpgrade.fromJson(json);
  }

  @override
  int getCost() {
    return pow(2, super.getLevel()).toInt();
  }

  double getBoost() {
    if (super.getLevel() == BaseUpgrade.startingLevel) {
      return 0;
    }
    return pow(3, .3 * (super.getLevel() - 1)).toDouble() - 1.29;
  }

}