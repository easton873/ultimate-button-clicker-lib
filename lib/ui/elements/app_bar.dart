import 'package:button_clicker/ui/elements/back_button.dart';
import 'package:button_clicker/ui/elements/buy_button.dart';
import 'package:button_clicker/ui/elements/buying_amount.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  static const double topPadding = 8.0;
  static const double bottomPadding = 5.0;

  Widget getTopRightButton() {
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(3.0, topPadding, 0.0, bottomPadding),
          child: CustomBackButton(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, topPadding, 10.0, bottomPadding),
          child: getTopRightButton(),
        ),
      ],
    );
  }
}

class ShopAppBar extends CustomAppBar {
  const ShopAppBar({super.key});

  @override
  Widget getTopRightButton() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
          child: GameText("Buying Quantity", fontSize: 12.0),
        ),
        BuyingAmountToggler(),
      ],
    );
  }
}