import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class StartingClickUpgrade extends Upgrade {
  StartingClickUpgrade() : super(BaseUpgrade(name: "Starting Clicks", maxLevel: 15));

  StartingClickUpgrade.fromJson(Map json) : super(BaseUpgrade.fromJson(json));

  @override
  decodeJson(Map<String, dynamic> json) {
    return StartingClickUpgrade.fromJson(json);
  }

  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }

  @override
  int getCost(int level) {
    if (level == 1) {
      return 2;
    } else if (level == 2) {
      return 16;
    }
    return (100 * pow(2, (level - 2))).toInt();
  }

  double getStartingClicks() {
    return getStartingClicksByLevel(super.getLevel());
  }

  double getStartingClicksByLevel(int level) {
    if (level == 1) {
      return 0;
    }
    return pow(10, level).toDouble();
  }

  @override
  String getSpecificDescrption(int level) {
    return "${getStartingClicksByLevel(level).toInt()}";
  }

  @override
  String getDescription() {
    return "Clicks";
  }
}