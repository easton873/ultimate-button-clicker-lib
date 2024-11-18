import 'package:button_clicker/game/const.dart';
import 'package:flutter/material.dart';

class UnlockPoint {
  static Widget getImage(double fontSize) {
    return Image.asset(
      "${Constants.imagesPath}/unlock_point.png",
      width: fontSize,
      height: fontSize,
    );
  }

  static WidgetSpan getImageSpan(double fontSize) {
    return WidgetSpan(
      child: getImage(fontSize)
    );
  }

  static Widget getImageWithBackground(double fontSize) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: getImage(fontSize),
    );
  }
}