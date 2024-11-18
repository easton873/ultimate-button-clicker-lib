import 'package:button_clicker/game/mco.dart';
import 'package:flutter/material.dart';

class GameColor {
  static bool isBrightColor(Color color) {
    int r = color.red;
    int g = color.green;
    int b = color.blue;

    // Calculate luminance
    double luminance = (0.299 * r + 0.587 * g + 0.114 * b);

    return luminance > 128;
  }

  static Color getCurrGameColor() {
    return MCO().currGame.data.color;
  }

  static Color getCurrGameSecondaryColor() {
    return MCO().currGame.data.secondaryColor;
  }

  static Color getCurrGameContrastColor(Color color) {
    return isBrightColor(color) ? Colors.black : Colors.white;
  }

  static ButtonStyle getCurrGameElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: getCurrGameColor(),
      foregroundColor: getCurrGameSecondaryColor()
    );
  }

  static Color parseColorFromText(String colorCode) {
    return Color(int.parse("FF$colorCode", radix: 16));
  }
}

