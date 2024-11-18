import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class BonusEarnedOnResetDisplay extends GameUpdateWidget {
  const BonusEarnedOnResetDisplay({super.key});

  @override
  State<BonusEarnedOnResetDisplay> createState() => _BonusEarnedOnResetDisplayState();
}

class _BonusEarnedOnResetDisplayState extends GameUpdateWidgetState<BonusEarnedOnResetDisplay> {
  @override
  Widget build(BuildContext context) {
    int newBonuses = MCO().currGame.getNewBonus();
    return SizedBox(
      height: 100,
      child: GameTextWithPadding(
        'You will gain\n${MCO().currGame.displayNewBonus()} ${getBonusPluralOrNot(newBonuses)}\nwhen you reset',
      ),
    );
  }
}