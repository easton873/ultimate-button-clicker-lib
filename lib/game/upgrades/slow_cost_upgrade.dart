import 'dart:math';

import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class SlowClickerCostUpgrade extends Upgrade {
  SlowClickerCostUpgrade() : super(BaseUpgrade(name: "Slow Clicker Cost Increase", maxLevel: 20));

  SlowClickerCostUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return SlowClickerCostUpgrade.fromJson(json);
  }

  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  @override
  int getCost(int level) {
    return (level * (pow(1.5, level) * 3)).toInt();
  }

  double getCostIncreaseRateByLevel(double originalRate, int level) {
    // 1-(1-a)e^-.3x
    // x = level
    // a = originalRate
    return 1 - (1 - originalRate) * pow(e, -.3*(level - 1));
  }

  double getCostIncreaseRate(double originalRate) {
    return getCostIncreaseRateByLevel(originalRate, super.getLevel());
  }

  @override
  String getSpecificDescrption(int level) {
    double rate = 1.1;
    double original = getCostIncreaseRateByLevel(rate, 1) - 1;
    double discount = 1 - (getCostIncreaseRateByLevel(rate, level) - 1) / original;
    return Constants.displayPercentage(discount);
  }
  
  @override
  String getDescription() {
    return "Cost Growth Slowed Percentage";
  }
}