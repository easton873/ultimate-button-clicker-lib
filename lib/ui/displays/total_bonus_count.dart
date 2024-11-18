import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/displays/reset_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class TotalBonusCountDisplay extends GameResetWidget {
  const TotalBonusCountDisplay({super.key});

  @override
  State<TotalBonusCountDisplay> createState() => _TotalBonusCountDisplayState();
}

class _TotalBonusCountDisplayState extends GameResetWidgetState<TotalBonusCountDisplay> {
  @override
  Widget build(BuildContext context) {
    num numBonuses = MCO().currGame.getNumBonuses();
    String bonusText = getBonusPluralOrNot(numBonuses.toInt());
    return GameTextWithPadding(
      'You have\n${MCO().currGame.displayBonus()}\n$bonusText',
    );
  }
}