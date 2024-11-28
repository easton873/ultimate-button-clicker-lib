import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickPower extends Upgrade {
  ClickPower() : super(BaseUpgrade(name: "Clicks per click", maxLevel: 20));

  @override
  getCost(int level) {
    return pow(2, level - 1).toInt();
  }

  int getClickPower() {
    return getClickPowerByLevel(super.getLevel());
  }

  ClickPower.fromJson(Map json) : super(BaseUpgrade.fromJson(json));
  
  @override
  decodeJson(Map<String, dynamic> json) {
    return ClickPower.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  int getClickPowerByLevel(int level) {
    return pow(2, level - 1).toInt();
  }

  @override
  String getSpecificDescrption(int level) {
    return "X${getClickPowerByLevel(level)}";
  }

  @override
  String getDescription() {
    return "Click Boosted";
  }
}