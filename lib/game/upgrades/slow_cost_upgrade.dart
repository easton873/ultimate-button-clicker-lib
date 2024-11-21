import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class SlowClickerCostUpgrade extends Upgrade {
  SlowClickerCostUpgrade() : super(BaseUpgrade(name: "Slow Clicker Cost Increase"));

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
  int getCost() {
    return super.getLevel() * 3;
  }

  double getCostIncreaseRate(double originalRate) {
    // 1-(1-a)e^-.3x
    // x = level
    // a = originalRate
    return 1 - (1 - originalRate) * pow(e, -.3*(super.getLevel() - 1));
  }

}