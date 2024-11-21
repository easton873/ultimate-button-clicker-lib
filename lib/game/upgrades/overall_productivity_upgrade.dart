import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class OverallProductivityUpgrade extends Upgrade {
  OverallProductivityUpgrade() : super(BaseUpgrade(name: "Overall Productivity", maxLevel: 1000));

  OverallProductivityUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return OverallProductivityUpgrade.fromJson(json);
  }

  @override
  int getCost() {
    return super.getLevel() * pow(10, 1 + ((super.getLevel() - 1) * .05)).toInt();
  }

  double getBoost() {
    // e^.2x - 1
    return pow(e, .3 * super.getLevel()) - 1;
  }
}