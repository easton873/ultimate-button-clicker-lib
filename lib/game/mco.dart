import 'dart:async';

import 'package:button_clicker/game/buying_amount.dart';
import 'package:button_clicker/game/clicker_upgrade.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/game/general_data.dart';
import 'package:button_clicker/game/loadout_manager.dart';
import 'package:button_clicker/game/observable_game.dart';
import 'package:button_clicker/game/tutorial.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/save/load_json.dart';
import 'package:button_clicker/save/save_data.dart';

class MCO extends ObservableGame {
  static final MCO _singleton = MCO._internal();

  factory MCO() {
    return _singleton;
  }
  
  MCO._internal();

  late Game currGame;
  GeneralData settings = GeneralData();
  bool isInitialized = false;
  // Stack<GameState> currState = Stack();
  BuyingAmountState buyingAmount = OneState();
  Tutorial tutorial = Tutorial();
  Upgrades upgrades = Upgrades();

  void run() {
    Timer.periodic(Duration(milliseconds: Constants.gameRateAsMillisecond), (Timer timer) {
      if (isInitialized) {
        if (!tutorial.isGameDisabled()) {
          currGame.update();
        }
        checkGameWon();
        notifyGameUpdate();
      }
    });
  }

  void reset() {
    currGame.reset();
    currGame.save();
    notifyGameReset();
  }

  void clearCurrGame() {
    currGame.clear();
    currGame.save();
    notifyGameReset();
  }

  void checkGameWon() {
    if (currGame.gameIsWon) {
      return;
    }
    if (currGame.detectWin()) {
      settings.completeLevel(currGame.data);
      _saveSettings();
      currGame.gameIsWon = true;
      notifyGameWin();
      currGame.save();
    }
  }

  void updateState() {
    notifyGameUpdate();
    // currState.peek.updateState();
  }

  void updateFromResume() {
    Game data = SaveData().loadData(currGame, currGame.data.saveKey); // load most recent save to get totalClicks and timestamp
    currGame.updateFromResume(data);
  }

  void initialize() {
    _initialize().then((_) {
      isInitialized = true;
      forceUpdate();
    });
    MCO().run();
  }

  Future<void> _initialize() async {
    await SaveData().initSharedPreferences();
    _loadUpgrades();
    Game.upgrades = upgrades;
    ClickerUpgrade.upgrades = upgrades;
    // load loadouts first
    LoadJson loader = LoadJson(AppWay());
    dynamic json = await loader.readJson('assets/loadouts/loadouts.json');
    LoadoutManager.fromJson(json);
    // load saveData
    GameData.defaultData = LoadoutManager.getDefaultGameData();
    currGame = Game.fromGameData(GameData.defaultData);
     _loadSettings();
    _checkTutorialData();
    final data = await SaveData().initData(currGame);
    currGame = Game(data);
  }

  // settings
  void buyGame() {
    settings.purchased = true;
    _saveSettings();
  }

  bool canUnlockLevel() {
    return upgrades.numLevels.getTotalLevelsUnlocked() - settings.diffUnlockedLevelsAndCompletedLevels() > 0;
  }

  void attemptUnlock(String key) {
    if (!settings.isUnlocked(key) && canUnlockLevel())  {
      settings.unlock(key);
      _saveSettings();
    }
  }

  void _loadSettings() {
    settings = SaveData().loadData(settings, SaveData.generalDataSaveKey);
  }

  void _loadUpgrades() {
    upgrades = SaveData().loadData(upgrades, Upgrades.saveKey);
  }

  void _checkTutorialData() {
     // ensure the tutorial doesn't start halfway complete
    if (!settings.tutorialCompleted) {
      SaveData().wipeTutorialData();
    }
  }

  void _saveSettings() {
    SaveData().saveData(settings, SaveData.generalDataSaveKey);
  }

  void _saveUpgrades() {
    SaveData().saveData(upgrades, Upgrades.saveKey);
  }

  void doTutorial() {
    tutorial.tickTutorial(MCO().currGame);
    if (tutorial.isTutorialComplete()) {
      completeTutorial();
    }
  }

  void completeTutorial() {
    settings.completeTutorial();
    _saveSettings();
  }

  void refundLevel(String key) {
    if (!settings.isLevelCompleted(key) && settings.isUnlocked(key) && !currGame.isCurrGame(key)) {
      settings.refund(key);
      SaveData().wipeKey(key);
      _saveSettings();
    }
  }

  void tryBuyUpgrade(Upgrade upgrade) {
    settings.spendXP(upgrade.buy(settings.getXP()));
    _saveSettings();
    _saveUpgrades();
  }
}