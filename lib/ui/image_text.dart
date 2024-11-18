import 'package:button_clicker/ui/unlock_point.dart';
import 'package:flutter/material.dart';

class ImageText {
  static const String image = "!M@G3";
  static const double defaultFontSize = 16.0;
  static const TextStyle defaultStyle = TextStyle(fontSize: defaultFontSize, color: Colors.black);

  static Widget gameTextWithImage(String s, double fontSize, TextStyle style) {
    List<InlineSpan> messages = [];
    for (String chunk in s.split(image)) {
      if (chunk != "") {
        messages.add(
          TextSpan(
            text: chunk,
            style: style
          )
        );
      }
      
      messages.add(
       UnlockPoint.getImageSpan(fontSize)
      );
    }
    messages.removeLast();
    return RichText(
      text: TextSpan(
        children: messages
      )
    );
  }
}