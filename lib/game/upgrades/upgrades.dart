import 'package:button_clicker/game/upgrades/click_power_upgrade.dart';
import 'package:button_clicker/game/upgrades/clicker_discount_upgrade.dart';
import 'package:button_clicker/game/upgrades/num_levels_upgrade.dart';
import 'package:button_clicker/game/upgrades/slow_cost_upgrade.dart';
import 'package:button_clicker/game/upgrades/starting_click_upgrade.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/to_json.dart';

class BaseUpgrade implements JsonMarshaller, JsonUnmarshaller {
  String name;
  int level = 1;
  num cost;

  BaseUpgrade(this.name, this.cost);

  static const String jsonName = "name";
  static const String jsonLevel = "level";
  static const String jsonCost = "cost";

  BaseUpgrade.fromJson(Map json) : 
    name = json[jsonName],
    level = json[jsonLevel],
    cost = json[jsonCost];

  @override
  decodeJson(Map<String, dynamic> json) {
    return BaseUpgrade.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return {
      jsonName: name,
      jsonLevel: level,
      jsonCost: cost,
    };
  }
}

abstract class Upgrade implements JsonMarshaller, JsonUnmarshaller {
  final BaseUpgrade _base;

  Upgrade(this._base);

  // buy() returns the number of points spent
  int buy(int points) {
    if (points >= _base.cost) {
      int paidCost = _base.cost.toInt();
      _base.level++;
      _base.cost = increaseCost();
      return paidCost;
    }
    return 0;
  }

  int increaseCost();

  String getName() {
    return _base.name;
  }

  int getCost() {
    return _base.cost.toInt();
  }

  setCost(int newCost) {
    _base.cost = newCost;
  }

  int getLevel() {
    return _base.level;
  }

  BaseUpgrade getBase() {
    return _base;
  }
}

class Upgrades implements JsonMarshaller, JsonUnmarshaller {
  ClickPower power;
  StartingClickUpgrade startingClick;
  NumLevelsUpgrade numLevels;
  SlowCostUpgrade slowCost;
  ClickerDiscountUpgrade clickerDiscount;

  Upgrades() : 
    power = ClickPower(),
    startingClick = StartingClickUpgrade(),
    numLevels = NumLevelsUpgrade(),
    slowCost = SlowCostUpgrade(),
    clickerDiscount = ClickerDiscountUpgrade();

  static const String saveKey = "upgrades";
  static const String jsonPower = "power";
  static const String jsonStartingClicks = "startingClicks";
  static const String jsonNumLevels = "numLevels";
  static const String jsonSlowCost = "slowCost";
  static const String jsonClickerDiscount = "clickerDiscount";

  List<Upgrade> getUpgrades() {
    return [
      power,
      startingClick,
      numLevels,
      slowCost,
      clickerDiscount,
    ];
  }

  Upgrades.fromJson(Map json) :
    power = json[jsonPower] != null ? ClickPower.fromJson(json[jsonPower]) :  ClickPower(),
    startingClick = json[jsonStartingClicks] != null ? StartingClickUpgrade.fromJson(json[jsonStartingClicks]) : StartingClickUpgrade(),
    numLevels = json[jsonNumLevels] != null ? NumLevelsUpgrade.fromJson(json[jsonNumLevels]) : NumLevelsUpgrade(),
    slowCost = json[jsonSlowCost] != null ? SlowCostUpgrade.fromJson(json[jsonSlowCost]) : SlowCostUpgrade(),
    clickerDiscount = json[jsonClickerDiscount] != null ? ClickerDiscountUpgrade.fromJson(json[jsonClickerDiscount]) : ClickerDiscountUpgrade();
  
  @override
  decodeJson(Map<String, dynamic> json) {
    return Upgrades.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return {
      jsonPower: power.encodeJson(),
      jsonStartingClicks: startingClick.encodeJson(),
      jsonNumLevels: numLevels.encodeJson(),
      jsonClickerDiscount: clickerDiscount.encodeJson(),
    };
  }
}