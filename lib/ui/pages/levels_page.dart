import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/game/loadout_manager.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/save/save_data.dart';
import 'package:button_clicker/ui/app_bar.dart';
import 'package:button_clicker/ui/image_text.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/refund_button.dart';
import 'package:flutter/material.dart';

class LevelsPage extends GameSidePage {
  const LevelsPage({super.key});
  
  @override
  GameState<GamePage> createState() => _LevelsPageState();
}

class _LevelsPageState extends GameSidePageState<LevelsPage> {  
  late LoadoutManager lm;
  static const double fontSize = 24;
  static const TextStyle textStyle = TextStyle(
    fontSize: fontSize,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  void notifyGameWon() {
    super.notifyGameWon();
    updateState();
  }

  bool isUnlocked(String key) {
    return MCO().settings.isUnlocked(key);
  }

  bool isCompleted(String key) {
    return MCO().settings.isLevelCompleted(key);
  }

  // String getUnlockPointsStr() {
  //   return "${MCO().settings.unlockPoints}";
  // }

  List<Widget> getColumnChildren() {
    // const double fontSize = 24.0;
    const double subFontSize = 16.0;
    return [
      // ImageText.gameTextWithImage("Bank: ${ImageText.image}${getUnlockPointsStr()}", fontSize, textStyle),
      Expanded(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(), // Stops scrolling immediately at the edges
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          itemCount: LoadoutManager.loadouts.length,
          itemBuilder: (BuildContext context, int index) {
            String key = LoadoutManager.loadouts.keys.elementAt(index);
            GameData currGameData = LoadoutManager.loadouts[key] ?? GameData.defaultData;
            return DecoratedBox(
              decoration: BoxDecoration( 
              image: DecorationImage( 
                image: AssetImage("${Constants.imagesPath}/${currGameData.backgroundImagePath}"), fit: BoxFit.cover),
              ),
              child: Row(children: 
                [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft, 
                            child: GameText(key)
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: (isCompleted(currGameData.saveKey)) ?
                                const GameText("Completed", fontSize: subFontSize) 
                              : 
                                Row(children: 
                                  [
                                    GameText("Reward: ${currGameData.reward}", fontSize: subFontSize,),
                                    // ...[for (int i = 0; i < currGameData.reward; i++) UnlockPoint.getImageWithBackground(fontSize)]
                                  ] 
                                ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  getOtherLoadoutButton(key, currGameData, context)
                ]
              ),
            );
          }
        ),
      ),
    ];
  }

  Widget getRefundButton(String key) {
    Widget refundButton = const SizedBox.shrink();
    if (isUnlocked(key) && !isCompleted(key)) {
      refundButton = RefundButton(saveKey: key);
    }
    return refundButton;
  }

  Widget getOtherLoadoutButton(String key, GameData currGameData, BuildContext context) {
    Widget refundButton = getRefundButton(key);

    Widget buttonText = const Text("Switch", style: textStyle);
    void Function()? buttonFn = () { 
      switchLoadout(key, currGameData, context); 
      MCO().forceUpdate();
    };
    if (MCO().currGame.data.saveKey == key) {
      buttonText = const Text("Current", style: textStyle);
      buttonFn = null;
      refundButton = const SizedBox.shrink();
    }
    else if (!isUnlocked(key)) {
      buttonText = ImageText.gameTextWithImage("${ImageText.image}1", fontSize, textStyle);
      // buttonText = RichText(text: TextSpan(
      //   children: [
      //     UnlockPoint.getImageSpan(fontSize),
      //     const TextSpan(
      //       text: "1",
      //       style: textStyle
      //     )
      //   ]
      // ));
      buttonFn = () {
        unlockLoadout(key);
        updateState();
      };
      if (!MCO().canUnlockLevel()) {
        buttonFn = null;
      }
    }

    return Row(
      children: [
        refundButton,
        ElevatedButton(
          onPressed: buttonFn, 
          child: buttonText
        ),
      ],
    );
  }

  // Widget getLoadoutButton(String key, GameData currGameData, BuildContext context) {
  //   String buttonText = "Switch";
  //   void Function()? buttonFn = () { switchLoadout(key, currGameData, context); };
  //   if (MCO().currGame.data.saveKey == key) {
  //     buttonText = "Current";
  //     buttonFn = null;
  //   }
  //   else if (!isUnlocked(key)) {
  //     buttonText = "Unlock";
  //     buttonFn = () {
  //       doUnlockConfirmation(context, key);
  //     };
  //   } 
  //   return ElevatedButton(
  //     onPressed: buttonFn, 
  //     child: Text(buttonText,style: textStyle)
  //   );
  // }

  void switchLoadout(String key, GameData currGameData, BuildContext context) {
    MCO().currGame = Game(SaveData().loadData(Game.fromGameData(currGameData), key));
    MCO().currGame.save();
    Navigator.of(context).pop();
  }

  void unlockLoadout(String key) {
    MCO().attemptUnlock(key);
  }
  
  @override
  String getBackgroundImageName() {
    return "${Constants.imagesPath}/${MCO().currGame.data.backgroundImagePath}";
  }

  @override
  BoxDecoration getDecoration() {
    return const BoxDecoration();
  }

  @override
  CustomAppBar getAppBar() {
    return const LevelsAppBar();
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: getColumnChildren(),
    );
  }
}

// class _LevelsPageWithPurchase extends _LevelsPageState {
//   _LevelsPageWithPurchase();

//   bool isPurchased() {
//     return MCO().settings.purchased;
//   }

//   @override
//   bool isUnlocked(String key) {
//     if (isPurchased()) {
//       return true;
//     }
//     else {
//       return super.isUnlocked(key);
//     }
//   }

//   @override
//   String getUnlockPointsStr() {
//     if (isPurchased()) {
//       return '∞';
//     }
//     return super.getUnlockPointsStr();
//   }

//   @override
//   Widget getRefundButton(String key) {
//     if (isPurchased()) {
//       return const SizedBox.shrink();
//     }
//     return super.getRefundButton(key);
//   }
// }
