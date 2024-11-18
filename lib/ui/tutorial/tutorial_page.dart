import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/confirm.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/pages/main_page.dart';
import 'package:flutter/material.dart';

class TutorialPage extends MainPage {
  const TutorialPage({super.key, required super.title});

  @override
  GameState<GamePage> createState() => _TutorialPageState();
}

class _TutorialPageState extends MainPageState implements GameUpdateObserver {

  @override
  void initState() {
    super.initState();
    MCO().registerUpdateObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doTutorialConfirmation(context);
    });
  }

  @override
  void dispose() {
    MCO().unregisterUpdateObserver(this);
    super.dispose();
  }

  @override
  void notifyGameUpdate() {
    MCO().doTutorial();
    MCO().forceUpdate();
    // updateState();
  }

  @override
  void buttonClick() {
    if (MCO().tutorial.isButtonDisabled()) {
      return;
    }
    super.buttonClick();
  }

  @override
  void summaryTabButtonFn() {
    MCO().tutorial.summaryButtonPressed();
    super.summaryTabButtonFn();
  }

  @override
  void levelsTabButtonFn() {
    MCO().tutorial.levelsButtonPressed();
    super.levelsTabButtonFn();
  }

  @override
  void shopTabButtonFn() {
    MCO().tutorial.shopButtonPressed();
    super.shopTabButtonFn();
  }

  @override
  Widget buildHeader() {
    List<Widget> tabs = [];
    if (MCO().tutorial.getTabInfo().hasSummaryPage) {
      tabs.add(summaryTabButton());
    }
    if (MCO().tutorial.getTabInfo().hasShopPage) {
      tabs.add(shopTabButton());
    }
    if (MCO().tutorial.getTabInfo().hasBonusPage) {
      tabs.add(resetTabButton());
    }
    if (MCO().tutorial.getTabInfo().hasLevelsPage) {
      tabs.add(levelsTabButton());
    }
    if (tabs.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
        children: tabs,
      );
  }

  @override
  Widget buildText() {
    return GameTextWithPadding(MCO().tutorial.getText(MCO().currGame));
  }
}