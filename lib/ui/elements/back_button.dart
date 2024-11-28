import 'package:button_clicker/ui/color.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.circle,
          color: GameColor.getCurrGameColor(),
          size: 40.0
        ),
        IconButton(
          onPressed: (){ Navigator.pop(context); }, 
          icon: Icon(
            Icons.arrow_back,
            color: GameColor.getCurrGameSecondaryColor(),
          )
        )
      ]
    );
  }
}