import 'package:button_clicker/ui/game_controller.dart';
import 'package:button_clicker/ui/pages/bonus_page.dart';
import 'package:button_clicker/ui/tutorial/bonus_tutorial_page.dart';
import 'package:flutter/material.dart';

class BonusPageController extends GameController {
  const BonusPageController({super.key});

  @override
  State<BonusPageController> createState() => _BonusPageControllerState();
}

class _BonusPageControllerState extends GameControllerState<BonusPageController> {
  @override
  Widget buildWidget(BuildContext context) {
    return const BonusPage();
  }

  @override
  Widget buildTutorialWidget(BuildContext context) {
    return const BonusTutorialPage();
  }
}