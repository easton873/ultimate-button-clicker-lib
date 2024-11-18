import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/game_widget.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/pages/bonus_page.dart';
import 'package:flutter/material.dart';

class BonusTutorialPage extends BonusPage {
  const BonusTutorialPage({super.key});

  @override
  GameState<GamePage> createState() => _BonusTutorialPageState();
}

class _BonusTutorialPageState extends BonusPageState implements GameUpdateObserver {
  @override
  notifyGameUpdate() {
    updateState();
  }

  @override
  Widget getBonusCount() {
    if (MCO().tutorial.showBonusCount()) {
      return super.getBonusCount();
    }
    return const SizedBox.shrink();
  }

  @override
  List<Widget> getColumnChildren() {
    String text = MCO().tutorial.getBonusPageText(MCO().currGame);
    if (text != "") {
      return [
        GameTextWithPadding(text),
        getBonusCount(),
        const ResetButton()
      ];
    }
    return super.getColumnChildren();
  }  
}