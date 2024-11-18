import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/total_bonus_count.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:button_clicker/ui/game_widget.dart';
import 'package:flutter/material.dart';

class BonusPage extends GameSidePage {
  const BonusPage({super.key});
  
  @override
  GameState<GamePage> createState() => BonusPageState();
}

class BonusPageState extends GameSidePageState<BonusPage> {
   @override
  String getBackgroundImageName() {
    return MCO().currGame.data.getBgImagePath();
  }
  
  @override
  Alignment getDecorationAlignment() {
    return Alignment.centerRight;
  }

  Widget getBonusCount() {
    return const Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            TotalBonusCountDisplay(),
          ],
        ),
      ),
    );
  }

  List<Widget> getColumnChildren() {
    return [
      getBonusCount(),
      const Expanded(child: Column(
        children: [
          ResetButton(),
          ClearButton(),
        ],
      ))
    ];
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getColumnChildren(),
    );
  }
}