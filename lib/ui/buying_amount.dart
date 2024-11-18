import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:flutter/material.dart';

class BuyingAmountToggler extends StatefulWidget {
  const BuyingAmountToggler({super.key});

  @override
  State<BuyingAmountToggler> createState() => _BuyingAmountTogglerState();
}

class _BuyingAmountTogglerState extends State<BuyingAmountToggler> {
  String _buttonText = "";

  _BuyingAmountTogglerState() {
    _buttonText = MCO().buyingAmount.getText();
  }

  void changeBuyingAmount() {
    MCO().buyingAmount = MCO().buyingAmount.getNextState();
    setState(() {
      _buttonText = MCO().buyingAmount.getText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeBuyingAmount,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ElevatedButton(
            onPressed: changeBuyingAmount, 
            style: GameColor.getCurrGameElevatedButtonStyle(),
            child: const Text(" "),
          ),
          Text(_buttonText, style: TextStyle(fontWeight: FontWeight.bold, color: GameColor.getCurrGameSecondaryColor()),),
        ],
      ),
    );
  }
}