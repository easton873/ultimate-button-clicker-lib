import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickerDiscountUpgrade extends Upgrade {
  ClickerDiscountUpgrade() : super(BaseUpgrade(name: "Clicker Discount"));

  ClickerDiscountUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return ClickerDiscountUpgrade.fromJson(json);
  }

  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  @override
  int getCost() {
    return super.getLevel() * 3 - 1;
  }

  double getDiscount() {
    // e^-.3(x-1)
    // x is level
    return pow(e, -.3*(super.getLevel() - 1)).toDouble();
  }
}