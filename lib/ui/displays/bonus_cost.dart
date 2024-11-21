import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class HowMuchIstABonusDisplay extends StatelessWidget {
  const HowMuchIstABonusDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    String cost = Constants.displayInt(MCO().currGame.data.getBonusCost());
    String thingProducedStr = getThingProducedPluralOrNot(MCO().currGame.data.getBonusCost());
    return GameTextWithPadding(
      'You earn 1 ${MCO().currGame.data.bonusName}\nfor every\n$cost $thingProducedStr\nyou earn'
    );
  }
}