import 'dart:math';

import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class BonusDiscountUpgrade extends Upgrade {
  BonusDiscountUpgrade() : super(BaseUpgrade(name: "Bonus Cheaper"));

  BonusDiscountUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return BonusDiscountUpgrade.fromJson(json);
  }

  @override
  int getCost(int level) {
    return (level * (4 * pow(1.1, level)) - 3).toInt();
  }

  double getDiscount() {
    return getDiscountByLevel(super.getLevel());
  }

  double getDiscountByLevel(int level) {
    // e^-.3(x-1)
    return pow(e, (level-1) * -.3).toDouble();
  }

  @override
  String getSpecificDescrption(int level) {
    return Constants.displayPercentage(1 - getDiscountByLevel(level));
  }

  @override
  String getDescription() {
    return "Bonus Discount";
  }
}