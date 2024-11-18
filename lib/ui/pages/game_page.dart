import 'package:button_clicker/ui/confirm.dart';
import 'package:button_clicker/ui/game_ui.dart';
import 'package:flutter/material.dart';

abstract class GamePage extends GameUI {
  const GamePage({super.key});
}

abstract class GameState<T extends StatefulWidget> extends GameUIState<T> {
  @override
  void notifyGameWon() {
    showWonConfirmation(context);
  }
  
  void changeScreen(Widget newScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }

  @override
  Widget nextBuildStep(BuildContext context) {
    return buildWidget(context);
  }
}