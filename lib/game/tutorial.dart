import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/tab_info.dart';

class Tutorial {
  TutorialState _state = NeedsClickState();

  void tickTutorial(Game game) {
    if (_state.isStateComplete(game)) {
      _state = _state.getNextState(game);
    }
  }

  String getText(Game game) {
    return _state.getText(game);
  }

  String getShopText(Game game) {
    return _state.getShopText(game);
  }

  String getBonusPageText(Game game) {
    return _state.getBonusText(game);
  }

  String getSummaryText() {
    return _state.getSummaryText();
  }

  bool isButtonDisabled() {
    return _state.disableClicking;
  }

  TabInfo getTabInfo() {
    return _state.tabInfo;
  }
  
  bool isTutorialComplete() {
    return _state.tutorialComplete;
  }

  bool isGameDisabled() {
    return _state.disableGameClock;
  }

  void summaryButtonPressed() {
    _state.clickSummaryButton();
  }

  void levelsButtonPressed() {
    _state.clickLevelsButton();
  }

  void shopButtonPressed() {
    _state.clickShopButton();
  }

  List<Clicker> getClickers(Game game) {
    return _state.getShopClickers(game);
  }

  bool showBonusCount() {
    return _state.showBonusCount;
  }
}

abstract class TutorialState {
  TutorialState getNextState(Game game);
  bool isStateComplete(Game game);
  String getText(Game game);

  String getShopText(Game game) {
    return Constants.tutorialReturnToMainText;
  }

  String getBonusText(Game game) {
    return Constants.tutorialReturnToMainText;
  }

  String getSummaryText() {
    return Constants.tutorialReturnToMainText;
  }

  List<Clicker> getShopClickers(Game game) {
    return game.clickers;
  }

  void clickSummaryButton() {}
  void clickLevelsButton() {}
  void clickShopButton() {}

  bool disableClicking = false;
  TabInfo tabInfo = TabInfo();
  bool tutorialComplete = false;
  bool disableGameClock = false;
  bool showBonusCount = true;
}

class NeedsClickState extends TutorialState {
  @override
  TutorialState getNextState(Game game) {
    return NeedsClickerCostClickState();
  }
  
  @override
  bool isStateComplete(Game game) {
    return game.getClicks() >= 1;
  }
 
  @override
  String getText(Game game) {
    return 'Welcome to Ultimate Clicker Game!\nA Game where you enjoy clicking various things\nClick the Todo List once';
  }
}

class NeedsClickerCostClickState extends TutorialState {
  @override
  getNextState(Game game) {
    return NavigateToShopState();
  }
  
  @override
  bool isStateComplete(Game game) {
    return game.getClicks() >= game.clickers[1].getCost(1);
  }
  
  @override
  String getText(Game game) {
    int costOfFirstThing = game.clickers[1].getCost(1).toInt();
    String thingProducedStr = getThingProducedPluralOrNot(costOfFirstThing);
    return 'Click unitl you have $costOfFirstThing $thingProducedStr\n${writeCounter(game)}';
  }

}

class NavigateToShopState extends TutorialState {
  bool shopButtonPressed = false;
  NavigateToShopState() {
    disableClicking = true;
    tabInfo.hasShopPage = true;
  }

  @override
  getNextState(Game game) {
    return BuyFirstClicker();
  }

  @override
  bool isStateComplete(Game game) {
    return shopButtonPressed;
  }
  
  @override
  String getText(Game game) {
    return "Click the new shop button\non the top of the screen";
  }

  @override
  void clickShopButton() {
    shopButtonPressed = true;
  }

  @override
  List<Clicker> getShopClickers(Game game) {
    return [];
  }
}

class BuyFirstClicker extends TutorialState {
  BuyFirstClicker() {
    disableClicking = true;
    tabInfo.hasShopPage = true;
  }

  @override
  TutorialState getNextState(Game game) {
    return BuySecondClicker();
  }

  @override
  bool isStateComplete(Game game) {
    return game.clickers[0].quantity > 0;
  }
  
  @override
  String getShopText(Game game) {
    return "Buy 1 ${game.clickers[0].name}";
  }

  @override
  List<Clicker> getShopClickers(Game game) {
    return [
      game.clickers[0]
    ];
  }
  
  @override
  String getText(Game game) {
    return "Navigate to Shop Page to Continue";
  }
}

class BuySecondClicker extends TutorialState {
  BuySecondClicker(){
    disableClicking = true;
    tabInfo.hasShopPage = true;
  }

  @override
  TutorialState getNextState(Game game) {
    return BuyThirdClicker();
  }

  @override
  bool isStateComplete(Game game) {
    if (game.getClicks() >= game.clickers[1].getCost(1)) {
      disableClicking = true;
      disableGameClock = true;
    } else {
      disableClicking = false;
      disableGameClock = false;
    }
    return game.clickers[1].quantity > 0;
  }

  @override
  String getShopText(Game game) {
    return "Now buy 1 ${game.clickers[1].name}";
  }

  @override
  List<Clicker> getShopClickers(Game game) {
    return [
      game.clickers[0],
      game.clickers[1]
    ];
  }

  @override
  String getText(Game game) {
    return "Navigate to Shop Page to Continue";
  }
}

class BuyThirdClicker extends TutorialState {
  @override
  TutorialState getNextState(Game game) {
    return BonusNeedsEarningState();
  }

  @override
  String getText(Game game) {
    return "Navigate to Shop Page to Continue";
  }

  @override
  String getShopText(Game game) {
    return "Now buy 1 ${game.clickers[2].name}";
  }

  @override
  bool isStateComplete(Game game) {
    if (game.getClicks() >= game.clickers[2].getCost(1)) {
      disableClicking = true;
      disableGameClock = true;
    } else {
      disableClicking = false;
      disableGameClock = false;
    }
    return game.clickers[2].quantity > 0;
  }

}

class BonusNeedsEarningState extends TutorialState {
  BonusNeedsEarningState() {
    tabInfo.hasShopPage = true;
  }

  @override
  getNextState(Game game) {
    return BonusEarnedState();
  }

  @override
  String getText(Game game) {
    int bonusCost = game.data.getBonusCost();
    String thingProducedStr = getThingProducedPluralOrNot(bonusCost);
    return "Keep earning until you've\ngot $bonusCost $thingProducedStr\n${writeCounter(game)}";
  }

  @override
  String getShopText(Game game) {
    int bonusCost = game.data.getBonusCost();
    String thingProducedStr = getThingProducedPluralOrNot(bonusCost);
    return "Keep earning until you've\ngot $bonusCost $thingProducedStr";
  }

  @override
  bool isStateComplete(Game game) {
    return game.getNewBonus() > 0;
  }

}

class BonusEarnedState extends TutorialState {
  BonusEarnedState() {
    tabInfo.hasShopPage = true;
    tabInfo.hasBonusPage = true;
    showBonusCount = false;
    disableClicking = true;
    disableGameClock = true;
  }
  @override
  getNextState(Game game) {
    return CheckOutSummaryPageState();
  }

  @override
  String getText(Game game) {
    return "Click the Bonus Tab\non the top of the screen";
  }

  @override
  String getBonusText(Game game) {
    return "Click the reset button\nand reset";
  }

  @override
  bool isStateComplete(Game game) {
    return game.getNumBonuses() > 0;
  }

}

class CheckOutSummaryPageState extends TutorialState {
  bool summaryButtonPressed = false;

  CheckOutSummaryPageState() {
    tabInfo.hasShopPage = true;
    tabInfo.hasBonusPage = true;
    tabInfo.hasSummaryPage = true;
    disableClicking = true;
  }
  
  @override
  TutorialState getNextState(Game game) {
    return FinishGame();
  }
  
  @override
  String getText(Game game) {
    return "Click the Summary Tab";
  }
  
  @override
  bool isStateComplete(Game game) {
    return summaryButtonPressed;
  }

  @override
  void clickSummaryButton() {
    summaryButtonPressed = true;
  }
}

class FinishGame extends TutorialState {
  FinishGame() {
    tabInfo.hasShopPage = true;
    tabInfo.hasBonusPage = true;
    tabInfo.hasSummaryPage = true;
  }
  @override
  TutorialState getNextState(Game game) {
    if (game.gameIsWon) {
      return VisitLevelsPageState();
    }
    else if (game.getClicks() >= 50.0 && !game.hasAnyClickers()) {
      return BuySomethingFromTheShopPleaseState();
    }
    return this;
  }

  @override
  String getText(Game game) {
    String thingPerBonus = getThingProducedPluralOrNot(game.data.getBonusCost());
    String bonusStr = getBonusPluralOrNot(game.data.winningPoint);
    return "Every ${game.data.getBonusCost()} $thingPerBonus\nearns you 1 ${game.data.bonusName}\nEarn ${game.data.winningPoint} $bonusStr\nto complete this level\n${writeCounter(game)}";
  }

  @override
  String getShopText(Game game) {
    return "Buy some clickers\nto click for you";
  }

  @override
  String getBonusText(Game game) {
    if (game.getNewBonus() > 0) {
      return "Reset to claim your bonus\nand increase your boost";
    }
    return "Get more clicks to\nearn more bonuses";
  }

  @override
  String getSummaryText() {
    return "Check this page out\nand navigate back\nto the main screen\nwhen you're done";
  }

  @override
  bool isStateComplete(Game game) {
    return true;
  }
}

class BuySomethingFromTheShopPleaseState extends FinishGame {
  @override
  TutorialState getNextState(Game game) {
    if (game.gameIsWon) {
      return VisitLevelsPageState();
    } else if (game.getClicks() < 50.0 || game.hasAnyClickers()) {
      return FinishGame();
    }
    return this;
  }

  @override
  String getText(Game game) {
    return "Go buy some clickers\nfrom the shop\n${writeCounter(game)}";
  }

  @override
  bool isStateComplete(Game game) {
    disableClicking = !game.hasAnyClickers();
    return true;
  }
}

class VisitLevelsPageState extends TutorialState {
  bool done = false;

  VisitLevelsPageState() {
    tabInfo.trueAll();
    disableClicking = true;
    disableGameClock = true;
  }

  @override
  TutorialState getNextState(Game game) {
    return TutorialDoneState();
  }

  @override
  String getText(Game game) {
    return "Last step in the tutorial\nGo press the Levels button to unlock and\n play another level. Every level has \na reward that allows you to unlock more";
  }

  @override
  bool isStateComplete(Game game) {
    return done;
  }

  @override
  void clickLevelsButton() {
    done = true;
  }

}

class TutorialDoneState extends TutorialState {
  TutorialDoneState() {
    tutorialComplete = true;
  }

  @override
  getNextState(Game game) {
    throw UnimplementedError();
  }

  @override
  bool isStateComplete(Game game) {
    return false;
  }
  
  @override
  String getText(Game game) {
    return 'Tutorial done';
  }

}

String writeCounter(Game game) {
  return "Clicks: ${game.getClicks().toInt()}";
}