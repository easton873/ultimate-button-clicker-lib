import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:button_clicker/ui/pages/debug_page.dart';
import 'package:button_clicker/ui/displays/total_click.dart';
import 'package:button_clicker/ui/game_widget.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/pages/levels_page.dart';
import 'package:button_clicker/ui/bonus_page_controller.dart';
import 'package:button_clicker/ui/pages/upgrades_page.dart';
import 'package:button_clicker/ui/shope_page_controller.dart';
import 'package:button_clicker/ui/summary_page_controller.dart';
import 'package:flutter/material.dart';

class MainPage extends GamePage {
  const MainPage({super.key, required this.title});
  final String title;
  
  @override
  GameState<GamePage> createState() => MainPageState();
}

class MainPageState extends GameState<MainPage> with WidgetsBindingObserver {
  double buttonSize = 300;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // this is run everytime the app is resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      MCO().updateFromResume();
    }
  }

  Widget tabButton({required Widget child, void Function()? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: GameColor.getCurrGameColor(),
          minimumSize: const Size(double.infinity, 60),
          padding: const EdgeInsets.all(2.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Set square corners
          ),
        ),
        onPressed: onPressed, 
        child: child
      )
    );
  }

  Widget shopTabButton() {
    return tabButton(onPressed: () => shopTabButtonFn(), child: const GameText('Shop', fontSize: 12.0));
  }

  Widget levelsTabButton() {
    return tabButton(onPressed: () => levelsTabButtonFn(), child: const GameText('Levels', fontSize: 12.0));
  }

  Widget resetTabButton() {
    return tabButton(onPressed: () => bonusTabButtonFn(), child: const GameText('Bonus', fontSize: 12.0));
  }

  Widget summaryTabButton() {
    return tabButton(onPressed: () => summaryTabButtonFn(), child: const GameText('Summary', fontSize: 12.0));
  }

  Widget upgradesTabButton() {
    return tabButton(onPressed: () => upgradesTabButtonFn(), child: const GameText('Upgrades', fontSize: 12.0,));
  }

  void shopTabButtonFn() {
    changeScreen(const ShopPageController());
  }

  void levelsTabButtonFn() {
    changeScreen(const LevelsPage());
  }

  void summaryTabButtonFn() {
    changeScreen(const SummaryPageController());
  }

  void bonusTabButtonFn() {
    changeScreen(const BonusPageController());
  }

  void upgradesTabButtonFn() {
    changeScreen(const UpgradesPage());
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        summaryTabButton(),
        shopTabButton(),
        resetTabButton(),
        levelsTabButton(),
        upgradesTabButton(),
        tabButton(onPressed: () => changeScreen(const DebugPage()), child: const GameText('Debug', fontSize: 12.0)),
      ],
    );
  }

  Widget buildText() {
    return const TotalClicksDisplay();
  }

  void buttonClick() {
    MCO().currGame.click();
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration( 
            // Image set to background of the body
            image: DecorationImage( 
                image: AssetImage(MCO().currGame.data.getBgImagePath()), fit: BoxFit.cover, alignment: Alignment.center),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row of buttons at the top
                buildHeader(),
                // Spacer to push the following widgets to the bottom
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     ScalingDownBox(child: buildText()),
                      GestureDetector(
                        onTapDown: (TapDownDetails details){
                          setState(() {
                            buttonClick();
                            buttonSize = 275;
                          });
                        },
                        onTapUp: (TapUpDetails details) {
                          setState(() {
                            buttonSize = 300;
                          });
                        },
                        child: SizedBox(
                          height: 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: buttonSize,
                              child: Image.asset('${Constants.imagesPath}/${MCO().currGame.data.buttonImagePath}')
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        )
      ),
    );
  }
}
