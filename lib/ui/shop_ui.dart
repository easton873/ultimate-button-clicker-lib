import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class ShopRow extends GameUpdateWidget {
  final Clicker clicker;
  // final Function updateState;
  const ShopRow(this.clicker, {super.key});

  @override
  State<ShopRow> createState() => _ShopRowState(clicker);
}

class _ShopRowState extends GameUpdateWidgetState<ShopRow> {
  Clicker clicker;
  // Function updateState;

  void buy() {
    MCO().buyingAmount.buy(MCO().currGame, clicker);
    MCO().updateState();
  }

  _ShopRowState(this.clicker);

  @override
  Widget build(BuildContext context) {
    int amount = getAmountAttemptingToBuy();
    int amountToShowCostFor = amount == 0 ? 1 : amount; // make sure cost displayed is for at least 1
    String buyButtonText = getBuyButtonText(amount);
    Function()? buttonFn = buy;
    if (!isButtonEnabled(amount)) {
      buttonFn = null;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: SizedBox(
        height: 200,
        child: Container( // Semi-transparent blue color
          decoration: BoxDecoration(
            border: Border.all(width: 5.0, color: GameColor.getCurrGameSecondaryColor()),//.withOpacity(0.5)),
            color: GameColor.getCurrGameColor(),//.withOpacity(0.8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GameText('${clicker.quantity} ${clicker.name}'),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const GameText("Cost: "),
                                GameText(Constants.displayDoubleNoDecimal(clicker.getCost(amountToShowCostFor)), textColor: const Color.fromARGB(255, 255, 150, 150),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GameText("${MCO().currGame.data.getPerSecondAbbrev()}: "),
                                GameText(Constants.displayDouble(MCO().currGame.getClickersClicksPerSecond(clicker).toDouble()), textColor: const Color.fromARGB(255, 150, 255, 150),)
                              ],
                            ),
                          ),
                          GameText("Total ${MCO().currGame.data.getPerSecondAbbrev()}: ${Constants.displayDouble(MCO().currGame.getClickersTotalClicksPerSecond(clicker).toDouble())}")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 120, height: 50, child: ElevatedButton(onPressed: buttonFn, child: GameText(buyButtonText))),
            ],
          ),
        ),
      ),
    );
  }

  int getAmountAttemptingToBuy() {
    return MCO().buyingAmount.getAmount(MCO().currGame, clicker);
  }

  String getBuyButtonText(int amount) {
    StringBuffer buttonText = StringBuffer();
    buttonText.write("Buy");
    if (amount < 0) {
      buttonText.write(" ∞");
    } 
    else if (MCO().buyingAmount.getText() != "1") {
      buttonText.write(" $amount");
    }
    return buttonText.toString();
  }

  bool isButtonEnabled(int amount) {
    return MCO().buyingAmount.canBuy(MCO().currGame, clicker, amount) && amount > 0 && clicker.quantity != Constants.maxInteger;
  }
}