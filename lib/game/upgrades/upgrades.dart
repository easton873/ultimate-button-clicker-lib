import 'package:button_clicker/game/upgrades/bonus_boost_upgrade.dart';
import 'package:button_clicker/game/upgrades/bonus_cheaper_upgrade.dart';
import 'package:button_clicker/game/upgrades/click_power_upgrade.dart';
import 'package:button_clicker/game/upgrades/clicker_discount_upgrade.dart';
import 'package:button_clicker/game/upgrades/num_levels_upgrade.dart';
import 'package:button_clicker/game/upgrades/overall_productivity_upgrade.dart';
import 'package:button_clicker/game/upgrades/reward_upgrade.dart';
import 'package:button_clicker/game/upgrades/slow_cost_upgrade.dart';
import 'package:button_clicker/game/upgrades/starting_click_upgrade.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/to_json.dart';

class BaseUpgrade implements JsonMarshaller, JsonUnmarshaller {
  static const int startingLevel = 1;

  String name;
  int level = startingLevel;
  int maxLevel;

  BaseUpgrade({required this.name, this.maxLevel = 10});

  static const String jsonName = "name";
  static const String jsonLevel = "level";
  static const String jsonMax = "max";

  BaseUpgrade.fromJson(Map json) : 
    name = json[jsonName],
    level = json[jsonLevel],
    maxLevel = json[jsonMax];

  @override
  decodeJson(Map<String, dynamic> json) {
    return BaseUpgrade.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return {
      jsonName: name,
      jsonLevel: level,
      jsonMax: maxLevel,
    };
  }
}

abstract class Upgrade implements JsonMarshaller, JsonUnmarshaller {
  final BaseUpgrade _base;

  Upgrade(this._base);

  @override
  Map encodeJson() {
    return getBase().encodeJson();
  }

  // buy() returns the number of points spent
  int buy(int points) {
    if (isMax()) {
      return 0;
    }
    num cost = getCost();
    if (points >= cost) {
      int paidCost = cost.toInt();
      _base.level++;
      return paidCost;
    }
    return 0;
  }

  String getName() {
    return _base.name;
  }

  int getCost();

  int getLevel() {
    return _base.level;
  }

  bool isMax() {
    return _base.level >= _base.maxLevel;
  }

  BaseUpgrade getBase() {
    return _base;
  }

  reset() {
    _base.level = BaseUpgrade.startingLevel;
  }
}

class Upgrades implements JsonMarshaller, JsonUnmarshaller {
  static Upgrades _singleton = Upgrades.fromNothing();

  factory Upgrades() {
    return _singleton;
  }

  setUpgrades(Upgrades upgrades) {
    _singleton = upgrades;
  }

  ClickPower power;
  StartingClickUpgrade startingClick;
  NumLevelsUpgrade numLevels;
  SlowClickerCostUpgrade slowCost;
  ClickerDiscountUpgrade clickerDiscount;
  BonusDiscountUpgrade bonusDiscount;
  BonusBoostUpgrade bonusBoost;
  OverallProductivityUpgrade overall;
  RewardUpgrade reward;

  Upgrades.fromNothing() : 
    power = ClickPower(),
    startingClick = StartingClickUpgrade(),
    numLevels = NumLevelsUpgrade(),
    slowCost = SlowClickerCostUpgrade(),
    clickerDiscount = ClickerDiscountUpgrade(),
    bonusDiscount = BonusDiscountUpgrade(),
    bonusBoost = BonusBoostUpgrade(),
    overall = OverallProductivityUpgrade(),
    reward = RewardUpgrade();
  

  static const String saveKey = "upgrades";
  static const String jsonPower = "power";
  static const String jsonStartingClicks = "startingClicks";
  static const String jsonNumLevels = "numLevels";
  static const String jsonSlowCost = "slowCost";
  static const String jsonClickerDiscount = "clickerDiscount";
  static const String jsonBonusDiscount = "bonusDiscount";
  static const String jsonBonusBoost = "bonusBoost";
  static const String jsonOverall = "overall";
  static const String jsonReward = "reward";


  List<Upgrade> getUpgrades() {
    return [
      power,
      startingClick,
      numLevels,
      slowCost,
      clickerDiscount,
      bonusDiscount,
      bonusBoost,
      overall,
      reward,
    ];
  }

  Upgrades.fromJson(Map json) :
    power = json[jsonPower] != null ? ClickPower.fromJson(json[jsonPower]) :  ClickPower(),
    startingClick = json[jsonStartingClicks] != null ? StartingClickUpgrade.fromJson(json[jsonStartingClicks]) : StartingClickUpgrade(),
    numLevels = json[jsonNumLevels] != null ? NumLevelsUpgrade.fromJson(json[jsonNumLevels]) : NumLevelsUpgrade(),
    slowCost = json[jsonSlowCost] != null ? SlowClickerCostUpgrade.fromJson(json[jsonSlowCost]) : SlowClickerCostUpgrade(),
    clickerDiscount = json[jsonClickerDiscount] != null ? ClickerDiscountUpgrade.fromJson(json[jsonClickerDiscount]) : ClickerDiscountUpgrade(),
    bonusDiscount = json[jsonBonusDiscount] != null ? BonusDiscountUpgrade.fromJson(json[jsonBonusDiscount]) : BonusDiscountUpgrade(),
    bonusBoost = json[jsonBonusBoost] != null ? BonusBoostUpgrade.fromJson(json[jsonBonusBoost]) : BonusBoostUpgrade(),
    overall = json[jsonOverall] != null ? OverallProductivityUpgrade.fromJson(json[jsonOverall]) : OverallProductivityUpgrade(),
    reward = json[jsonReward] != null ? RewardUpgrade.fromJson(json[jsonReward]) : RewardUpgrade();
  
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
      jsonSlowCost: slowCost.encodeJson(),
      jsonClickerDiscount: clickerDiscount.encodeJson(),
      jsonBonusDiscount: bonusDiscount.encodeJson(),
      jsonBonusBoost: bonusBoost.encodeJson(),
      jsonOverall: overall.encodeJson(),
      jsonReward : reward.encodeJson(),
    };
  }

  reset() {
    getUpgrades().forEach((Upgrade upgrade) {
      upgrade.reset();
    });
  }
}