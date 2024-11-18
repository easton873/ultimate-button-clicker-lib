import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class TotalClicksDisplay extends GameUpdateWidget {
  const TotalClicksDisplay({super.key});

  @override
  State<TotalClicksDisplay> createState() => _TotalClicksDisplayState();
}

class _TotalClicksDisplayState extends GameUpdateWidgetState<TotalClicksDisplay> {
  @override
  Widget build(BuildContext context) {
    return GameTextWithPadding(
      "${MCO().currGame.data.summaryText}:\n${MCO().currGame.displayTotalClicks()}"
    );
  }
}