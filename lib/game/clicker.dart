import 'dart:math';

import 'package:button_clicker/game/const.dart';

class Clicker {
  int quantity;
  double clicksPerSecond;
  double originalCost;
  double costIncreaseRate;
  String name;

  Clicker(this.name, this.quantity, this.originalCost, this.clicksPerSecond, this.costIncreaseRate);

  static const String clickerName = "name";
  static const String clickerQuantity = "quantity";
  static const String clickerCost = "cost";
  static const String clickerClicksPerSecond = "clicksPerSecond";
  static const String clickerCostIncreaseRate = "costIncreaseRate";
  static const String clickerThing = "thing";
  static const String clickerThingPlural = "thing_plural";
  static const String clickerBonusPlural = "bonus_plural";

  Clicker.fromJson(Map<dynamic, dynamic> json) : 
  name = json[clickerName], 
  quantity = 0,
  clicksPerSecond = json[clickerClicksPerSecond],
  originalCost = json[clickerCost],
  costIncreaseRate = json[clickerCostIncreaseRate]{
    if (json.containsKey(clickerQuantity)) {
      quantity = json[clickerQuantity];
    }
  }

  Map toJson() => {
    clickerName: name,
    clickerQuantity: quantity,
    clickerClicksPerSecond: clicksPerSecond,
    clickerCost: originalCost,
    clickerCostIncreaseRate: costIncreaseRate,
  };

  static final Clicker emptyClicker = Clicker("", 0, 0, 0, 0);

  double addClicks(int bonus) {
    return quantity * (clicksPerSecond * Constants.gameRate);
  }

  double getCostIncreaseRate() {
    return costIncreaseRate;
  }

  double getOriginalCost() {
    return originalCost;
  }

  void buyClickerAmount(int amount) {
    increaseQuantity(amount);
  }

  void increaseQuantity(int amount) {
    quantity+=amount;
  }

  double getCost(int amount) {
    return _getCostFromZeroQuantity(amount + quantity) - _getCostFromZeroQuantity(quantity);
  }

  double _getCostFromZeroQuantity(int amount) {
    return getOriginalCost() * ((getCostIncreaseRate() * pow(getCostIncreaseRate(), amount - 1) - 1) / (getCostIncreaseRate() - 1));
  }

  int getBuyableAmount(double clicks) {
    double currCost = _getCostFromZeroQuantity(quantity);
    return _getBuyableAmountFromZeroQuantity(clicks + currCost).toInt() - quantity;
  }

  double _getBuyableAmountFromZeroQuantity(double clicks) {
    return log(((getCostIncreaseRate() - 1) * (clicks - getOriginalCost()) / (getCostIncreaseRate() * getOriginalCost())) + 1) / log(getCostIncreaseRate()) + 1;
    // return log((((clicks - originalCost) * (costIncreaseRate - 1)) / (costIncreaseRate * originalCost)) + 1) / log(costIncreaseRate) + 1;
  }

  double getCurrClickRate(double _) {
    return clicksPerSecond * quantity;
  }

  double getClicksPerSecond(double _) {
    return clicksPerSecond;
  }

  void reset() {
    quantity = 0;
  }
}