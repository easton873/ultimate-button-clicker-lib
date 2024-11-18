import 'package:button_clicker/game/clicker_escape.dart';
import 'package:button_clicker/game/const.dart';

class ClickerFoodBonus extends ClickerEscape {
  ClickerFoodBonus(super.name, super.quantity, super.originalCost, super.clicksPerSecond, super.costIncreaseRate);

  ClickerFoodBonus.fromJson(super.json) : super.fromJson();

  @override
  double addClicks(int bonus) {
    return super.addClicks(bonus) * bonus;
  }

  @override
  double getCurrClickRate(double totalBonusRate) {
    return Constants.roundToOneDecimal(super.getCurrClickRate(totalBonusRate) * totalBonusRate);
  }

  @override
  double getClicksPerSecond(double totalBonusRate) {
    return Constants.roundToOneDecimal(super.getClicksPerSecond(totalBonusRate) * totalBonusRate);
  }
}