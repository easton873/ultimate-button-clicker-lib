import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/clicker_presenter.dart';
import 'package:button_clicker/game/clicker_upgrade.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/slow_cost_upgrade.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('slow cost upgrade', () async {
    Upgrades upgrades = Upgrades();
    SlowCostUpgrade upgrade = upgrades.slowCost;
    expect(upgrade.getCostIncreaseRate(1.1), 1.1);
    upgrade.buy(100);
    expect(upgrade.getCostIncreaseRate(1.1), 1.097044553354851);
    upgrade.buy(100);
    expect(upgrade.getCostIncreaseRate(1.1), 1.094176453358425);

    ClickerUpgrade.upgrades = upgrades;
    Clicker clicker = ClickerPresenter("name", 0, 1, 1, 1.1);
    expect(clicker.getCost(1), 1.0);
    expect(clicker.getCost(2), 2.09);
  });

  test('slow cost upgrade 2', () async {
    Upgrades upgrades = Upgrades();
    ClickerUpgrade.upgrades = upgrades;
    SlowCostUpgrade upgrade = upgrades.slowCost;
    expect(upgrade.getCostIncreaseRate(1.1), 1.1);
    Clicker clicker = ClickerPresenter("name", 0, 1.0, 1, 1.1);
    expect(clicker.getCost(100), 137796.12);
    upgrade.buy(100);
    expect(clicker.getCost(100), 108496.1);
    upgrade.buy(100);
    expect(clicker.getCost(100), 86047.95);
    upgrade.buy(100);
    expect(clicker.getCost(100), 68728.76);
  });

  test('cost discount upgrade', () async {
    Upgrades noUpgrades = Upgrades();
    Upgrades upgrades = Upgrades();

    ClickerUpgrade.upgrades = upgrades;
    Clicker clicker = ClickerPresenter("name", 0, 1.0, 1, 1.1);
    
    upgrades.clickerDiscount.buy(100);

    double upgradeCost = clicker.getCost(1);

    ClickerUpgrade.upgrades = noUpgrades;

    double noUpgradeCost = Constants.presenterRoundToDecimal(clicker.getCost(1) * upgrades.clickerDiscount.getDiscount(), 2);

    expect(upgradeCost, noUpgradeCost);

    noUpgradeCost = Constants.presenterRoundToDecimal(clicker.getCost(100) * upgrades.clickerDiscount.getDiscount(), 2);

    ClickerUpgrade.upgrades = upgrades;

    upgradeCost = clicker.getCost(100);

    expect(upgradeCost, noUpgradeCost);
  });
}