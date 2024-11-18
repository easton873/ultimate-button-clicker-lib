import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:button_clicker/ui/image_text.dart';
import 'package:button_clicker/ui/pages/game_side_page.dart';
import 'package:flutter/material.dart';

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
  final List<Upgrade> upgrades = MCO().upgrades.getUpgrades();
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
                                  ImageText.gameTextWithImage("${ImageText.image}${upgrades[i].getCost()}", fontSize, textStyle)
                                ],
                              )
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white
                            ),
                            onPressed: () {
                              MCO().tryBuyUpgrade(upgrades[i]);
                              setState(() {
                                
                              });
                          }, child: const Text('Upgrade'))
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
  
  @override
  String getBackgroundImageName() {
    return "${Constants.imagesPath}/upgrades.jpeg";
  }
}