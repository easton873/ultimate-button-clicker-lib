import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class SlowCostUpgrade extends Upgrade {
  SlowCostUpgrade() : super(BaseUpgrade("Slow Clicker Cost Increase", 1));

  SlowCostUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return SlowCostUpgrade.fromJson(json);
  }

  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  @override
  int increaseCost() {
    return super.getLevel() * 3;
  }

  double getCostIncreaseRate(double originalRate) {
    // 1-(1-a)e^-.2x
    // x = level
    // a = originalRate
    return 1 - (1 - originalRate) * pow(e, -.03*(super.getLevel() - 1));
  }

}