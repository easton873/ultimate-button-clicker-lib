import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickPower extends Upgrade {
  ClickPower() : super(BaseUpgrade(name: "Clicks per click"));

  @override
  getCost() {
    return super.getLevel() + (super.getLevel() * pow(1.5, super.getLevel() - 1)).toInt();
  }

  int getClickPower() {
    return pow(2, super.getLevel() - 1).toInt();
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
}