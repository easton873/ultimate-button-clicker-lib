import 'package:button_clicker/ui/game_controller.dart';
import 'package:button_clicker/ui/pages/shop_page.dart';
import 'package:button_clicker/ui/tutorial/shop_tutorial_page.dart';
import 'package:flutter/material.dart';

class ShopPageController extends GameController {
  const ShopPageController({super.key});

  @override
  State<ShopPageController> createState() => _ShopPageControllerState();
}

class _ShopPageControllerState extends GameControllerState<ShopPageController> {
  @override
  Widget buildTutorialWidget(BuildContext context) {
    return const ShopTutorialPage();
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return const ShopPage();
  }
}