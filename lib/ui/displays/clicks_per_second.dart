import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class CPSDisplay extends GameUpdateWidget {
  const CPSDisplay({super.key});

  @override
  State<CPSDisplay> createState() => _CPSDisplayState();
}

class _CPSDisplayState extends GameUpdateWidgetState<CPSDisplay> {
  @override
  Widget build(BuildContext context) {
    String clicksPerSecond = Constants.displayDouble(MCO().currGame.getTotalClicksPerSecond());
    return GameTextWithPadding(
      'Total ${MCO().currGame.data.thingProducedPlural} per second:\n$clicksPerSecond'
    );
  }
}