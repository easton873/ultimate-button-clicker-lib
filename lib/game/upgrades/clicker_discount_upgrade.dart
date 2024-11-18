import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickerDiscountUpgrade extends Upgrade {
  ClickerDiscountUpgrade() : super(BaseUpgrade("Clicker Discount", 1));

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
  int increaseCost() {
    return super.getLevel() * 3 - 4;
  }

  double getDiscount() {
    // e^-.1(x-1)
    // x is level
    return pow(e, -.1*(super.getLevel() - 1)).toDouble();
  }
}