import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/elements/app_bar.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/pages/shop_page.dart';
import 'package:flutter/widgets.dart';

class ShopTutorialPage extends ShopPage {
  const ShopTutorialPage({super.key});

  @override
  GameState<GamePage> createState() => _ShopTutorialPageState();
}

class _ShopTutorialPageState extends ShopPageState implements GameUpdateObserver {
  @override
  void initState() {
    super.initState();
    MCO().registerUpdateObserver(this);
  }

  @override
  void dispose() {
    MCO().unregisterUpdateObserver(this);
    super.dispose();
  }
  @override
  List<Widget> getColumnChildren() {
    String text = MCO().tutorial.getShopText(MCO().currGame);
    if (text != "") {
      return [
        GameTextWithPadding(text), 
        ...super.getColumnChildren()
      ];
    }
    return super.getColumnChildren();
  }

  @override
  List<Clicker> getClickers() {
    return MCO().tutorial.getClickers(MCO().currGame);
  }
  
  @override
  notifyGameUpdate() {
    updateState();
  }

  @override
  CustomAppBar getAppBar() {
    return const CustomAppBar();
  }
}