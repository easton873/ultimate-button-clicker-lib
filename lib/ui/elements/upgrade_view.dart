import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class UpgradeView extends StatelessWidget {
  const UpgradeView({super.key, required this.upgrade});
  final Upgrade upgrade;
  final double fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const GameText("Level"),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: GameText(upgrade.getDescription()),
              ),
              const GameText("Cost"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: upgrade.getMaxLevel(),
            itemBuilder: (BuildContext context, int i) {
              int level = i + 1;
              String cost = upgrade.getLevel() >= level ? "✅" : "${upgrade.getCost(level - 1)}";
              return ListTile(
                leading: GameText("$level", fontSize: fontSize,),
                title: GameText(upgrade.getSpecificDescrption(level), fontSize: fontSize),
                trailing: GameText(cost, fontSize: fontSize,),
              );
            }
          ),
        ),
      ],
    );
  }
}