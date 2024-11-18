import 'dart:math';

import 'package:button_clicker/util/stack.dart';

class Constants {
  static const String gameDataName = "name";
  static const String gameDataSummaryText = "summaryText";
  static const String gameDataColor = "color";
  static const String gameDataSecondaryColor = "secondaryColor";
  static const String gameDataBonus = "bonus";
  static const String gameDataBonusRate = "bonus_rate";
  static const String gameDataBonusCost = "bonus_cost";
  static const String gameDataWinningPoint =  "winning_point";
  static const String gameDataReward =  "reward";

  static const String buttonImageSuffix = ".png";
  static const String backgroundImageSuffix = "_bg.png";

  static const String gameName = "Ultimate Clicker Game";

  static const String defaultGameDataKey = "Tutorial";  

  // Game Object Fields
  static const String gametotalClicks = "totalClicks";
  static const String gameFood = "bonus";
  static const String gameNewFood = "newBonus";
  static const String gameClickers = "clickers";
  static const String gameTotalClicks = "totalClicks";
  static const String gameLastSave = "lastSave";
  static const String gameGameData = "gameData";
  static const String gameGamePointEarned = "gamePointEarned";

  static const double gameRate = 0.1;
  static final int gameRateAsMillisecond = (gameRate * 1000).round();

  // Tutorial
  static const String tutorialReturnToMainText = "Navigate back to the main screen to continue";

  // Globally True
  static const int maxInteger =  0x7FFFFFF;
  static const String imagesPath = "assets/images";

  static double presenterRoundToDecimal(double number, int numDecimals) {
    return double.parse(number.toStringAsFixed(numDecimals));
  }

  static double roundToDecimal(double value, num numDecimals) {
    num toTheTenth = pow(10.0, numDecimals);
    value *= toTheTenth;
    value = value.roundToDouble();
    return value / toTheTenth;
  }

  static double roundToOneDecimal(double value) {
    return roundToDecimal(value, 1);
  }

  static String displayDouble(double num) {
    String dropDecimal = dropDecimalFromDouble(num);
    if (dropDecimal.contains('e')) {
      return dropDecimal;
    }
    return formatWithCommas(roundToOneDecimal(num).toString());
  }

  static String displayDoubleNoDecimal(double num) {
    String dropDecimal = dropDecimalFromDouble(num);
    if (dropDecimal.contains('e')) {
      return dropDecimal;
    }
    return formatWithCommas(dropDecimal);
  }

  static String dropDecimalFromDouble(double num) {
    String value = num.toString();
    if (value.contains("e")) {
      return value;
    }
    if (value.contains('.')) {
      List<String> parts = value.split('.');
      return parts[0];
    }
    return value;
  }

  static String displayInt(int num) {
    return formatWithCommas(num.toString());
  }

  static String formatWithCommas(String num) {
    Stack<String> sections = Stack();
    String decimalPart = "";
    if (num.contains(".")) {
      List<String> parts = num.split(".");
      num = parts[0];
      decimalPart = parts[1];
    }
    while (num.length > 3) {
      sections.push(num.substring(num.length - 3));
      num = num.substring(0, num.length - 3);
    }
    StringBuffer sb = StringBuffer();
    sb.write(num);
    while(sections.isNotEmpty) {
      sb.write(',');
      sb.write(sections.pop());
    }
    if (decimalPart != "") {
      sb.write(".");
      sb.write(decimalPart);
    }
    return sb.toString();
  }
}