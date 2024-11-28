import 'dart:math';

import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickerDiscountUpgrade extends Upgrade {
  ClickerDiscountUpgrade() : super(BaseUpgrade(name: "Clicker Discount", maxLevel: 30));

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
  int getCost(int level) {
    return (level * (3 * pow(1.2, level)) - 1).toInt();
  }

  double getDiscount() {
    return getDiscountByLevel(super.getLevel());
  }

  double getDiscountByLevel(int level) {
    // e^-.3(x-1)
    // x is level
    return pow(e, -.3*(level - 1)).toDouble();
  }

  @override
  String getSpecificDescrption(int level) {
    return Constants.displayPercentage(1 - getDiscountByLevel(level));
  }

  @override
  String getDescription() {
    return "Clicker Discount";
  }
}