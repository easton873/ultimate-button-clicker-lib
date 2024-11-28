import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/ui/elements/app_bar.dart';
import 'package:button_clicker/ui/elements/confirm.dart';
import 'package:button_clicker/ui/elements/info_button.dart';
import 'package:button_clicker/ui/elements/upgrade_view.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/image_text.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:button_clicker/ui/elements/refund_button.dart';
import 'package:flutter/material.dart';

ButtonStyle _myButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  );

class UpgradesPage extends GameSidePage {
  const UpgradesPage({super.key});

  @override
  State<UpgradesPage> createState() => _UpgradesPageState();
}

class _UpgradesPageState extends GameSidePageState<UpgradesPage> {
  static const double fontSize = 24;
  static const TextStyle textStyle = TextStyle(
    fontSize: fontSize,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  final List<Upgrade> upgrades = Upgrades().getUpgrades();
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageText.gameTextWithImage(ImageText.image, fontSize, textStyle),
            GameText("${MCO().settings.getXP()}")
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: upgrades.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.grey
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GameText("${upgrades[i].getName()}: "),
                              Row(
                                children: [
                                  GameText("Level ${upgrades[i].getLevel()}"),
                                  ImageText.gameTextWithImage("${ImageText.image}${upgrades[i].getCurrCost()}", fontSize, textStyle)
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InfoButton(buttonFn: (){
                              _showUpgradeInfoPopup(context, upgrades[i]);
                            }),
                          ),
                          getBuyButton(upgrades[i]),
                        ]
                      ),
                    ),
                  ),
                ),
              );
          }),
        ),
      ],
    );
  }

  Widget getBuyButton(Upgrade upgrade) {
    return ElevatedButton(
      style: _myButtonStyle,
      onPressed: upgrade.isMax() ? null : () {
        MCO().tryBuyUpgrade(upgrade);
        setState(() {});
    }, child: upgrade.isMax() ? const Text('Max') : const Text('Upgrade'));
  }
  
  @override
  String getBackgroundImageName() {
    return "${Constants.imagesPath}/upgrades.jpeg";
  }

  @override
  CustomAppBar getAppBar() {
    return UpgradesAppBar(context);
  }
}

class UpgradesAppBar extends CustomAppBar {
  final BuildContext context;
  const UpgradesAppBar(this.context, {super.key});

  @override
  Widget getTopRightButton() {
    return Row(
      children: [
        RefundButton(buttonFn: () {
          showUpgradeRefundConfirmation(context);
        }),
        ElevatedButton(
          style: _myButtonStyle,
          onPressed: () {
            _showPurchasePopup(context);
          },
          child: const Text("Buy"),
        ),
      ],
    );
  }
}

void _showPurchasePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buy Coins'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buyXP(context, '\$0.99', 100),
              _buyXP(context, '\$4.99', 1000),
              _buyXP(context, '\$19.99', 10000),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buyXP(BuildContext context, String price, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageText.gameTextWithImageDefault("${ImageText.image} $amount"),
          ElevatedButton(
            style: _myButtonStyle,
            onPressed: () {
              MCO().addXP(amount);
              MCO().forceUpdate();
              Navigator.of(context).pop();
            },
            child: Text(price),
          ),
        ],
      ),
    );
  }

  void _showUpgradeInfoPopup(BuildContext context, Upgrade upgrade) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(upgrade.getName()),
          content: UpgradeView(upgrade: upgrade),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      }
    );
  }