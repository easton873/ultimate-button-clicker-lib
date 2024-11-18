import 'package:button_clicker/game/clicker_food_bonus.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickerUpgrade extends ClickerFoodBonus {
  ClickerUpgrade(super.name, super.quantity, super.originalCost, super.clicksPerSecond, super.costIncreaseRate);

  ClickerUpgrade.fromJson(super.json) : super.fromJson();

  static late Upgrades upgrades;

  @override
  double getCostIncreaseRate() {
    return upgrades.slowCost.getCostIncreaseRate(super.getCostIncreaseRate());
  }

  @override
  double getOriginalCost() {
    return super.getOriginalCost() * upgrades.clickerDiscount.getDiscount();
  }
}