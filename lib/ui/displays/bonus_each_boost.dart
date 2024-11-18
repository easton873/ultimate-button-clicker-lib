import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class HowMuchDoesEachBonusBoostYouDisplay extends StatelessWidget {
  const HowMuchDoesEachBonusBoostYouDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameTextWithPadding(
      'Each ${MCO().currGame.data.bonusName} gains you a\n${Constants.displayDouble(MCO().currGame.data.bonusRateForPercentage().toDouble())}% boost'
    );
  }
}