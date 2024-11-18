
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/displays/reset_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class WinConditionDisplay extends GameResetWidget {
  const WinConditionDisplay({super.key});

  @override
  GameResetWidgetState<WinConditionDisplay> createState() => _WinConditionDisplayState();
}

class _WinConditionDisplayState extends GameResetWidgetState<WinConditionDisplay> {
  @override
  Widget build(BuildContext context) {
    return GameTextWithPadding(
      "Goal: earn\n${Constants.displayInt(MCO().currGame.data.winningPoint)}\n${getBonusPluralOrNot(MCO().currGame.data.winningPoint)}"
    );
  }
}