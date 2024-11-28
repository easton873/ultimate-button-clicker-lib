// import 'package:button_clicker/game/mco.dart';
// import 'package:button_clicker/ui/color.dart';
// import 'package:button_clicker/ui/game_ui.dart';
// import 'package:flutter/material.dart';

// class BuyButton extends GameUI {
//   const BuyButton({super.key});

//   @override
//   State<BuyButton> createState() => _BuyButtonState();
// }

// class _BuyButtonState extends State<BuyButton> {
//   VoidCallback? getOnPressed() {
//     if (!MCO().settings.purchased) {
//       return (){
//         MCO().buyGame();
//         MCO().forceUpdate();
//         setState(() {});
//       };
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const BuildYourOwnPage()),
//         );
//       }, 
//       style: GameColor.getCurrGameElevatedButtonStyle(),
//       // child: const Text('Buy All Levels')
//       child: const Text('Level Builder')
//     );
//   }
// }