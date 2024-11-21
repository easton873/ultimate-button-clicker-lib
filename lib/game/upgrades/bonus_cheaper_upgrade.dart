import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class BonusDiscountUpgrade extends Upgrade {
  BonusDiscountUpgrade() : super(BaseUpgrade(name: "Bonus Cheaper"));

  BonusDiscountUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return BonusDiscountUpgrade.fromJson(json);
  }

  @override
  int getCost() {
    return super.getLevel() * 4 - 3;
  }

  double getDiscount() {
    // e^-.3(x-1)
    return pow(e, (super.getLevel()-1) * -.3).toDouble();
  }
}