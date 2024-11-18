import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/const.dart';

class ClickerEscape extends Clicker {
  ClickerEscape(super.name, super.quantity, super.originalCost, super.clicksPerSecond, super.costIncreaseRate);

  ClickerEscape.fromJson(super.json) : super.fromJson();

  @override
  void increaseQuantity(int amount) {
    if (amount == Constants.maxInteger) {
      return;
    }
    if (quantity + amount < 0) {
      quantity = Constants.maxInteger;
    }
    super.increaseQuantity(amount);
  }

  @override
  int getBuyableAmount(double clicks) {
    if (getOriginalCost() == 0 || getCost(1) == 0) {
      return -1;
    }
    if (clicks < 0) {
      return -1;
    }
    if (getCostIncreaseRate() == 1) {
      return clicks ~/ getOriginalCost();
    }
    return super.getBuyableAmount(clicks);
  }

  @override
  double getCost(int amount) {
    if (amount <= 0) {
      return 0;
    }
    if (getCostIncreaseRate() == 1) {
      return getOriginalCost() * amount;
    }
    return super.getCost(amount);
  }
}