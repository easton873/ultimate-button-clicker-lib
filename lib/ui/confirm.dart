import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/image_text.dart';
import 'package:flutter/material.dart';

showResetConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ConfirmReset();
    },
  );
}

showRefunConfirmation(BuildContext context, String key) {
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return ConfirmationPopup(
        title: "Refund?", 
        content: "Refunding this level will give you back 1 ${ImageText.image} but it will wipe your progress on this level.",
         actions: [
          ButtonInfo("Cancel", (){ Navigator.of(context).pop(); }),
          ButtonInfo("Clear & Gain ${ImageText.image}", () { 
            MCO().refundLevel(key);
            MCO().forceUpdate();
            Navigator.of(context).pop(); 
          })
        ]
      );
    }
  );
}

class ConfirmReset extends GameUpdateWidget {
  const ConfirmReset({super.key});

  @override
  State<ConfirmReset> createState() => _ConfirmResetState();
}

class _ConfirmResetState extends GameUpdateWidgetState<ConfirmReset> {
  @override
  Widget build(BuildContext context) {
    Game game = MCO().currGame;
    return ConfirmationPopup(
      title: "Are you sure?",
      content: "Are you sure you'd like to reset? Your progress will be wiped, but you'll get to claim your ${game.displayNewBonus()} ${getBonusPluralOrNot(game.getNewBonus())}",
      actions: [
        ButtonInfo("Cancel", (){
          Navigator.of(context).pop();
        }),
        ButtonInfo("Continue", () {
          MCO().reset();
          Navigator.of(context).pop();
        }),
      ],
    );
  }
}

showClearConfirmation(BuildContext context) {
  String bonusText = getBonusPluralOrNot(MCO().currGame.data.winningPoint);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationPopup(
        title: "Are you sure?",
        content: "Are you sure you'd like to clear all of your progress (including your $bonusText)?",
        actions: [
          ButtonInfo("Cancel", () {
            Navigator.of(context).pop();
          }),
          ButtonInfo("Continue", () {
            MCO().clearCurrGame();
            Navigator.of(context).pop();
          })
        ]
      );
    },
  );
}

showWonConfirmation(BuildContext context) {
  String bonusText = getBonusPluralOrNot(MCO().currGame.data.winningPoint);
  String goalStr = Constants.displayInt(MCO().currGame.data.winningPoint);
  StringBuffer wonText = StringBuffer("You reached the goal of $goalStr $bonusText");
  wonText.write(", and have gained ${MCO().currGame.data.reward} ${ImageText.image}");
  wonText.write(". Would you like to clear ALL of your progress and start again with 0 $bonusText?");

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ConfirmationPopup(
        title: "You won!", 
        content: wonText.toString(), 
        actions: [
          ButtonInfo("Endless Mode", () {
            Navigator.of(context).pop();
          }),
          ButtonInfo("Clear Progress", () {
            MCO().clearCurrGame();
            Navigator.of(context).pop();
          })
        ]
      );
    },
  );
}

doTutorialConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationPopup(
        title: "Welcome", 
        content: "It looks like this is your first time playing, would you like to do a tutorial?", 
        actions: [
          ButtonInfo("No", () {
            MCO().completeTutorial();
            MCO().forceUpdate();
            Navigator.of(context).pop();
          }),
          ButtonInfo("Do Tutorial", () {
            Navigator.of(context).pop();
          })
        ]);
    },
  );
}

// doUnlockConfirmation(BuildContext context, String key) {
//   VoidCallback? unlockFn;
//   if (MCO().settings.unlockPoints > 0) {
//     unlockFn = () {
//       MCO().attemptUnlock(key);
//       Navigator.of(context).pop();
//     };
//   }

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return   ConfirmationPopup(
//         title: "Unlock Level", 
//         content: "Unlock by watching an Ad or use an ${ImageText.image}?", 
//         actions: [
//           ButtonInfo(
//             "Cancel", 
//             () {
//               Navigator.of(context).pop();
//             }
//           ),
//           ButtonInfo(
//             "Watch Ad",
//             () {
//               MCO().unlock(key);
//               Navigator.of(context).pop();
//             }
//           ),
//           ButtonInfo(
//             "${ImageText.image} 1",
//             unlockFn
//           )
//         ]
//       );
//     },
//   );
// }

Widget makeButton(String text, VoidCallback? onPressed) {
  return ElevatedButton(
    onPressed: onPressed, 
    style: GameColor.getCurrGameElevatedButtonStyle(),
    child: ImageText.gameTextWithImage(text, ImageText.defaultFontSize, ImageText.defaultStyle)
  );
}

class ButtonInfo {
  String text;
  VoidCallback? onPressed;

  ButtonInfo(this.text, this.onPressed);
}

class ConfirmationPopup extends StatelessWidget {
  const ConfirmationPopup({super.key, required this.title, required this.content, required this.actions});

  final List<ButtonInfo> actions;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: ImageText.gameTextWithImage(content, ImageText.defaultFontSize, ImageText.defaultStyle),
      actions: [for (ButtonInfo info in actions) makeButton(info.text, info.onPressed)],
    );
  }
}