import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/app_bar.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/shop_ui.dart';
import 'package:flutter/material.dart';

class ShopPage extends GameSidePage {
  const ShopPage({super.key});
  
  @override
  GameState<GamePage> createState() => ShopPageState();
}

class ShopPageState extends GameSidePageState<ShopPage> {
  List<Clicker> getClickers() {
    return MCO().currGame.clickers;
  }

  @override
  CustomAppBar getAppBar() {
    return const ShopAppBar();
  }

  List<Widget> getColumnChildren() {
    List<ShopRow> shopRows = [];
    for (Clicker clicker in getClickers()) {
      shopRows.add(ShopRow(clicker));
    }
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              TotalClicksDisplay(),
            ],
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), // Stops scrolling immediately at the edges
          child: Column(
            children: [
              ...shopRows
            ],
          ),
        ),
      ),
    ];
  }
  
  @override
  String getBackgroundImageName() {
    return MCO().currGame.data.getBgImagePath();
  }
  
  @override
  Alignment getDecorationAlignment() {
    return Alignment.centerRight;
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: getColumnChildren(),
    );
  }
}

class TotalClicksDisplay extends GameUpdateWidget {
  const TotalClicksDisplay({super.key});

  @override
  State<TotalClicksDisplay> createState() => _TotalClicksDisplayState();
}

class _TotalClicksDisplayState extends GameUpdateWidgetState<TotalClicksDisplay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox(child: Center(child: GameText(MCO().currGame.displayTotalClicks()))));
  }
}