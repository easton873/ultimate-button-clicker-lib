import 'package:button_clicker/game/clicker_food_bonus.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickerUpgrade extends ClickerFoodBonus {
  ClickerUpgrade(super.name, super.quantity, super.originalCost, super.clicksPerSecond, super.costIncreaseRate);

  ClickerUpgrade.fromJson(super.json) : super.fromJson();

  @override
  double getCostIncreaseRate() {
    return Upgrades().slowCost.getCostIncreaseRate(super.getCostIncreaseRate());
  }

  @override
  double getOriginalCost() {
    return super.getOriginalCost() * Upgrades().clickerDiscount.getDiscount();
  }
}