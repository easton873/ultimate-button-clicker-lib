import 'dart:math';
import 'dart:ui';

import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/clicker_presenter.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:flutter/material.dart';

class GameData {
  String saveKey;
  String _tier;
  String summaryText;
  Color color;
  Color secondaryColor;
  String backgroundImagePath;
  String buttonImagePath;
  String thingProduced;
  String thingProducedPlural;
  String bonusName;
  String bonusPlural;
  double _bonusRate;
  int _bonusCost;
  double _bonusIncreaseRate;
  int winningPoint;
  final int _reward;
  List<Clicker> clickers = [];

  static late GameData defaultData;
  
  static const String jsonBonusIncreaseRate = "bonusIncreaseRate";
  static const String jsonTier = "tier";

  GameData.fromJson(Map<dynamic, dynamic> json) : 
  thingProduced = json[Clicker.clickerThing],
  thingProducedPlural = json[Clicker.clickerThingPlural],
  _tier = json[jsonTier] ?? "Unknown",
  summaryText = json[Constants.gameDataSummaryText],
  color = GameColor.parseColorFromText(json[Constants.gameDataColor]),
  secondaryColor = Colors.black,
  bonusName = json[Constants.gameDataBonus],
  bonusPlural = json[Clicker.clickerBonusPlural],
  _bonusRate = json[Constants.gameDataBonusRate],
  _bonusCost = json[Constants.gameDataBonusCost],
  _bonusIncreaseRate = json[jsonBonusIncreaseRate] ?? 1.0,
  winningPoint = json[Constants.gameDataWinningPoint],
  _reward = json[Constants.gameDataReward],
  saveKey = json[Constants.gameDataName],
  backgroundImagePath = json[Constants.gameDataName] + Constants.backgroundImageSuffix, 
  buttonImagePath = json[Constants.gameDataName] + Constants.buttonImageSuffix {
    for (dynamic clicker in json[Constants.gameClickers]) {
      clickers.add(ClickerPresenter.fromJson(clicker));
    }
    backgroundImagePath = toImagePath(backgroundImagePath);
    buttonImagePath = toImagePath(buttonImagePath);
    _initializeSecondaryColor(json);
  }

  // GameData.fromUserInput(this.saveKey, this.summaryText, this.thingProduced, this.thingProducedPlural, this.bonusName, this.bonusPlural, this._bonusRate, this._bonusCost, this._bonusIncreaseRate, this.winningPoint, this.clickers, this._tier) : 
  // color = Colors.white,
  // secondaryColor = Colors.black,
  // backgroundImagePath = "custom_bg.png",
  // buttonImagePath = "button.png",
  // _reward = 0;

  void _initializeSecondaryColor(Map<dynamic, dynamic> json) {
    if (json.containsKey(Constants.gameDataSecondaryColor)) {
      secondaryColor = GameColor.parseColorFromText(json[Constants.gameDataSecondaryColor]);
    } else {
      secondaryColor = GameColor.getCurrGameContrastColor(color);
    }
  }

  String toImagePath(String path) {
    return path.replaceAll(" ", "_").toLowerCase();
  }

  double getBonusRate() {
    return _bonusRate + Upgrades().bonusBoost.getBoost();
  }

  set bonusRate(double bonusRate) {
    _bonusRate = bonusRate;
  }

  num bonusRateForPercentage() {
    return getBonusRate() * 100;
  }

  String getBgImagePath() {
    return "${Constants.imagesPath}/$backgroundImagePath";
  }

  String getPerSecondAbbrev() {
    return "${thingProduced[0].toUpperCase()}PS";
  }

  int getReward() {
    return _reward * Upgrades().reward.getMultiplier();
  }

  int getBonusCost() {
    return (_bonusCost.toDouble() * Upgrades().bonusDiscount.getDiscount()).toInt();
  }

  double getBonus(double clicks) {
    double base = _bonusCost.toDouble();
    double rate = _bonusIncreaseRate;
    if (rate <= 1) {
      return clicks / base;
    }
    return log(((clicks * (rate - 1)) / base) + 1) / log(rate);
  }
}