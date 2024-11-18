import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/reset_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class TotalBoostDisplay extends GameResetWidget {
  const TotalBoostDisplay({super.key});

  @override
  State<TotalBoostDisplay> createState() => _TotalBoostDisplayState();
}

class _TotalBoostDisplayState extends GameResetWidgetState<TotalBoostDisplay> {
  @override
  Widget build(BuildContext context) {
    return GameTextWithPadding(
      'Your current total boost is\n${MCO().currGame.getBonusPercentage()}'
    );
  }
}