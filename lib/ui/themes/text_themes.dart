import 'package:flutter/material.dart';
import 'package:notes/ui/themes/color_modes.dart';

class TextThemes {
  static TextStyle headline(ColorModes mode) {
    TextStyle _style = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.normal,
    );
    if (mode == ColorModes.light) {
      return _style.copyWith(color: Colors.black);
    } else {
      return _style.copyWith(color: Colors.white);
    }
  }

  static TextStyle itemTitle(ColorModes mode) {
    TextStyle _style = TextStyle();
    if (mode == ColorModes.light) {
      return _style.copyWith(color: Colors.black);
    } else {
      return _style.copyWith(color: Colors.white);
    }
  }
}
