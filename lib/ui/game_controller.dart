import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/game_ui.dart';
import 'package:flutter/material.dart';

abstract class GameController extends GameUI {
  const GameController({super.key});
}

abstract class GameControllerState<T extends StatefulWidget> extends GameUIState<T> {
  bool updatedTutorial = false;
  bool updatedMainScreen = false;

  void updateTutorial(){
    if (!updatedTutorial) {
      updatedTutorial = true;
      updatedMainScreen = false;
      updateState();
    }
  }

  void updateMain() {
    if (!updatedMainScreen) {
      updatedMainScreen = true;
      updatedTutorial = false;
      updateState();
    }
  }

  Widget buildTutorialWidget(BuildContext context) {
    return buildWidget(context);
  }

  @override
  notifyGameWon() {
    MCO().currGame.gameIsWon = false; // just in case the controller hasn't returned it's actual page yet.
  }

  @override
  Widget nextBuildStep(BuildContext context) {
    if (!MCO().settings.tutorialCompleted) {
      // updateTutorial();
      return buildTutorialWidget(context);
    }
    // updateMain();
    return buildWidget(context);
  }
}