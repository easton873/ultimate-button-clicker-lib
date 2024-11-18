import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/pages/summary_page.dart';
import 'package:flutter/material.dart';

class SummaryTutorialPage extends SummaryPage {
  const SummaryTutorialPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryTutorialPageState();
}

class _SummaryTutorialPageState extends SummaryPageState {
  @override
  List<Widget> getColumnChildren() {
    if (MCO().tutorial.getSummaryText() != "") {
      return [
        GameTextWithPadding(MCO().tutorial.getSummaryText()),
        ...super.getColumnChildren()
      ];
    }
    return super.getColumnChildren();
  }
}