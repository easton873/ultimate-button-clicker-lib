import 'dart:math';

import 'package:button_clicker/game/upgrades/upgrades.dart';

class StartingClickUpgrade extends Upgrade {
  StartingClickUpgrade() : super(BaseUpgrade("Starting Clicks", 2));

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
  int increaseCost() {
    return pow(4, super.getLevel()).toInt();
  }

  double getStartingClicks() {
    int level = super.getLevel();
    if (level == 1) {
      return 0;
    }
    return pow(10, level).toDouble();
  }

}