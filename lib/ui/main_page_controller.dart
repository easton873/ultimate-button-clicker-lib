import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/ui/game_controller.dart';
import 'package:button_clicker/ui/pages/main_page.dart';
import 'package:button_clicker/ui/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';

class MainPageController extends GameController {
  const MainPageController({super.key});
  
  @override
  GameControllerState<MainPageController> createState() =>_MainPageControllerState();
}

class _MainPageControllerState extends GameControllerState<MainPageController> {
  @override
  Widget buildTutorialWidget(BuildContext context) {
    return const TutorialPage(title: "Tutorial");
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return const MainPage(title: Constants.gameName);
  }
}