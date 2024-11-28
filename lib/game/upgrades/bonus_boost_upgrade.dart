import 'dart:math';

import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class BonusBoostUpgrade extends Upgrade {
  BonusBoostUpgrade() : super(BaseUpgrade(name: "Boost Bonus"));

  BonusBoostUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return BonusBoostUpgrade.fromJson(json);
  }

  @override
  int getCost(int level) {
    if (level == 1) {
      return 1;
    }
    return (5 * pow(1.1, level - 1) * level).toInt();
  }

  double getBoost() {
    return getBoostByLevel(super.getLevel());
  }

  double getBoostByLevel(int level) {
    if (level == BaseUpgrade.startingLevel) {
      return 0;
    }
    return pow(3, .4 * (level - 1)).toDouble() - 1.29;
  }

  @override
  String getSpecificDescrption(int level) {
    return Constants.displayPercentage(getBoostByLevel(level));
  }

  @override
  String getDescription() {
    return "Boost Increased Percentage";
  }
}