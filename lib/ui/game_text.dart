import 'dart:ui';

import 'package:flutter/material.dart';

class GameText extends Widget {
  final String text;
  final double fontSize;
  final Color textColor;

  const GameText(this.text, {super.key, this.fontSize = 24.0, this.textColor = Colors.white});

  @override
  Element createElement() {
    FeatheredText myText = FeatheredText(
      text: text, 
      fontSize: fontSize, 
      textColor: textColor
    );
    return myText.createElement();
  }
}

class FeatheredText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const FeatheredText({super.key, 
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    const double outerBlur = 8.0;
    const double innerBlur = 3.0;
    const Color blackColor = Color.fromARGB(255, 0, 0, 0);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(0.0, 3.0),
              blurRadius: innerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(0.0, -3.0),
              blurRadius: innerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(3.0, 0.0),
              blurRadius: innerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(-3.0, 0.0),
              blurRadius: innerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(0.0, 3.0),
              blurRadius: outerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(0.0, -3.0),
              blurRadius: outerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(3.0, 0.0),
              blurRadius: outerBlur,
              color: blackColor,
            ),
            Shadow(
              offset: Offset(-3.0, 0.0),
              blurRadius: outerBlur,
              color: blackColor,
            ),
          ],
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GameTextWithPadding extends Widget {
  final double fontSize;
  final String gameText;
  const GameTextWithPadding(this.gameText, {super.key, this.fontSize = 24.0});

  @override
  Element createElement() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameText(gameText),
    ).createElement();
  }
}