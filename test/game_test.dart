
import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/clicker_upgrade.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/game/loadout_manager.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/save/fake_saver.dart';
import 'package:button_clicker/save/load_json.dart';
import 'package:button_clicker/save/save_data.dart';
import 'package:flutter_test/flutter_test.dart';

// {
//         "clickers": [
//             {
//                 "name":"Idle Click Producer",
//                 "clicksPerSecond":1.0,
//                 "cost":10.0,
//                 "costIncreaseRate":1.0
//             },
//             {
//                 "name":"Increasing Cost Producer",
//                 "clicksPerSecond":1.0,
//                 "cost":1.0,
//                 "costIncreaseRate":2.0
//             }
//         ]
//     }
void main() {
  Upgrades upgrades = Upgrades();
  Game.upgrades = upgrades;
  ClickerUpgrade.upgrades = upgrades;
  test('Basic Game', () {
    Map json = {
      Clicker.clickerName:"Test",
      Clicker.clickerThing:"Foo",
      Clicker.clickerThingPlural:"Foos",
      Constants.gameDataSummaryText:"This is my summary",
      Constants.gameDataColor:"000000",
      Constants.gameDataBonus: "Bar",
      Clicker.clickerBonusPlural: "Bars",
      Constants.gameDataBonusCost: 10,
      Constants.gameDataBonusRate: 0.5,
      Constants.gameDataWinningPoint: 10,
      Constants.gameDataReward: 1,
      Constants.gameClickers: [
        {
          Clicker.clickerName: "Prodigal Son",
          Clicker.clickerClicksPerSecond: 5.0,
          Clicker.clickerCost: 10.0,
          Clicker.clickerCostIncreaseRate: 1.1,
        },
      ],
    };
    GameData gameData = GameData.fromJson(json);
    Game game = Game.fromGameData(gameData);
    SaveData().saveStrategy = FakeSaver(); 


    expect(game.clickers[0].getCost(1), 10.0);

    expect(game.getClicks(), 0.0);
    game.click();
    expect(game.getClicks(), 1.0);

    game.update();
    expect(game.getClicks(), 1.0);
    for (int i = 0; i < game.clickers[0].getCost(1); i++) {
      game.click();
    }
    expect(game.getClicks(), game.clickers[0].getCost(1) + 1.0);
    game.clickers[0].buyClickerAmount(1);
    expect(game.clickers[0].quantity, 1);
    expect(game.clickers[0].getCost(1), game.clickers[0].originalCost * game.clickers[0].costIncreaseRate);
  });

  test('load_json', () async {
    LoadJson loader = LoadJson(TestWay());
    List<dynamic> guy = await loader.readJson('assets/loadouts/loadouts.json');
    LoadoutManager.fromJson(guy);
  });

  test('time passing', () async {
    LoadJson loader = LoadJson(TestWay());
    List<dynamic> guy = await loader.readJson('assets/loadouts/loadouts.json');
    LoadoutManager.fromJson(guy);
    Game game = Game.fromGameData(LoadoutManager.getDefaultGameData());
    game.clickers[0].quantity = 10;
    game.clickers[0].clicksPerSecond = 1;
    game.lastSave = DateTime.now().subtract(const Duration(seconds: 10));
    Game loadedGame = Game(game);
    expect(loadedGame.getClicks(), 100.0);
    expect(loadedGame.getTotalClicksPerSecond(), 10.0);
  });

  test('time passing with bonus', () async {
    LoadJson loader = LoadJson(TestWay());
    List<dynamic> guy = await loader.readJson('assets/loadouts/loadouts.json');
    LoadoutManager.fromJson(guy);
    Game game = Game.fromGameData(LoadoutManager.getDefaultGameData());
    game.clickers[0].quantity = 10;
    game.clickers[0].clicksPerSecond = 1;
    game.lastSave = DateTime.now().subtract(const Duration(seconds: 10));
    game.setBonusTestONLY(1);
    game.data.bonusRate = 1;
    Game loadedGame = Game(game);
    expect(loadedGame.getClicks(), 200.0);
    expect(loadedGame.getTotalClicksPerSecond(), 20.0);
    expect(game.getClickersClicksPerSecond(loadedGame.clickers[0]), 2.0);
    expect(game.getClickersTotalClicksPerSecond(loadedGame.clickers[0]), 20.0);
  });

  test('bonus rate of non-whole number', () async {
    LoadJson loader = LoadJson(TestWay());
    List<dynamic> guy = await loader.readJson('assets/loadouts/loadouts.json');
    LoadoutManager.fromJson(guy);
    Game game = Game.fromGameData(LoadoutManager.getDefaultGameData());
    game.clickers[0].quantity = 10;
    game.clickers[0].clicksPerSecond = 1;
    game.lastSave = DateTime.now().subtract(const Duration(seconds: 10));
    game.setBonusTestONLY(5);
    game.data.bonusRate = 0.1;
    Game loadedGame = Game(game);
    expect(loadedGame.getClicks(), 150.0);
    expect(loadedGame.getTotalClicksPerSecond(), 15.0);
    expect(game.getClickersClicksPerSecond(loadedGame.clickers[0]), 1.5);
    expect(game.getClickersTotalClicksPerSecond(loadedGame.clickers[0]), 15.0);
  });
}