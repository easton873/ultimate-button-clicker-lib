import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:button_clicker/ui/displays/bonus_cost.dart';
import 'package:button_clicker/ui/displays/bonus_each_boost.dart';
import 'package:button_clicker/ui/displays/bonus_on_reset.dart';
import 'package:button_clicker/ui/displays/clicks_per_second.dart';
import 'package:button_clicker/ui/displays/total_bonus_count.dart';
import 'package:button_clicker/ui/displays/total_boost.dart';
import 'package:button_clicker/ui/displays/total_click.dart';
import 'package:button_clicker/ui/displays/win_condition.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

String getBonusPluralOrNot(int numBonuses) {
  String text = MCO().currGame.data.bonusPlural;
  if (numBonuses == 1) {
    text = MCO().currGame.data.bonusName;
  }
  return text;
}

String getThingProducedPluralOrNot(int numThingProduced) {
  String text = MCO().currGame.data.thingProducedPlural;
  if (numThingProduced == 1) {
    text = MCO().currGame.data.thingProduced;
  }
  return text;
}

class SummaryDisplay extends StatelessWidget {
  const SummaryDisplay({super.key, required this.summaryText, required this.children});
  final String summaryText;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
      color: Colors.black,//.withOpacity(0.4),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: GameColor.getCurrGameColor(),//.withOpacity(0.8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: GameText(summaryText, fontSize: 16.0,),
            )
          ),
        ),
        ...children
      ],
    ),
  );
  }
}

class ClickSummaryDisplay extends StatelessWidget {
  const ClickSummaryDisplay({super.key, required this.summaryText});
  final String summaryText;

  @override
  Widget build(BuildContext context) {
    return SummaryDisplay(
    summaryText: summaryText,
    children: const [
      TotalClicksDisplay(),
      CPSDisplay(),
    ],
  );
  }
}

class BonusSummaryDisplay extends StatelessWidget {
  const BonusSummaryDisplay({super.key, required this.summaryText});
  final String summaryText;

  @override
  Widget build(BuildContext context) {
    return SummaryDisplay(
      summaryText: summaryText,
      children: const [
          TotalBonusCountDisplay(),
          HowMuchIstABonusDisplay(),
          BonusEarnedOnResetDisplay(),
        ]
    );
  }
}

class WinConditionSummary extends StatelessWidget {
  const WinConditionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const SummaryDisplay(summaryText:"Win Condition",
      children: [
        WinConditionDisplay(),
      ],
    );
  }
}

class BoostSummaryDisplay extends StatelessWidget {
  const BoostSummaryDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const SummaryDisplay(summaryText: "Boost Summary",
      children:
        [
          HowMuchDoesEachBonusBoostYouDisplay(),
          TotalBoostDisplay(),
        ],
    );
  }
}