import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:flutter/material.dart';

class SummaryPage extends GameSidePage {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => SummaryPageState();
}

class SummaryPageState extends GameSidePageState<SummaryPage> {

  @override
  String getBackgroundImageName() {
    return MCO().currGame.data.getBgImagePath();
  }

  @override
  Alignment getDecorationAlignment() {
    return Alignment.centerLeft;
  }

  List<Widget> getColumnChildren() {
    return [
      const WinConditionSummary(),
      ClickSummaryDisplay(summaryText: "${MCO().currGame.data.thingProduced} Summary"),
      BonusSummaryDisplay(summaryText: "${MCO().currGame.data.bonusName} Summary"),
      const BoostSummaryDisplay(),
    ];
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: getColumnChildren(),
      ),
    );
  }
}