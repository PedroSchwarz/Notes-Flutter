import 'package:flutter/material.dart';
import 'package:notes/entities/priority.dart';

class PrioritiesColors {
  static Color getColorByPriority({
    @required Priority priority,
    bool selected = false,
  }) {
    switch (priority) {
      case Priority.Low:
        return selected ? Colors.green.shade800 : Colors.green;
      case Priority.Medium:
        return selected ? Colors.amber.shade800 : Colors.amber;
      case Priority.High:
        return selected ? Colors.red.shade800 : Colors.red;
      default:
        return selected ? Colors.green.shade800 : Colors.green;
    }
  }
}
