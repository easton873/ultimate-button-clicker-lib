import 'package:button_clicker/game/clicker_upgrade.dart';
import 'package:button_clicker/game/const.dart';

class ClickerPresenter extends ClickerUpgrade {
  ClickerPresenter(super.name, super.quantity, super.originalCost, super.clicksPerSecond, super.costIncreaseRate);

  ClickerPresenter.fromJson(super.json) : super.fromJson();

  @override
  double getCurrClickRate(double totalBonusRate) {
    return double.parse(super.getCurrClickRate(totalBonusRate).toStringAsFixed(2));
  }

  @override
  double getCost(int amount) {
    return Constants.presenterRoundToDecimal(super.getCost(amount), 2);
  }

  @override
  double getClicksPerSecond(double bonus) {
    return double.parse(super.getClicksPerSecond(bonus).toStringAsFixed(2));
  }
}