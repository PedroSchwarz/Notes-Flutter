import 'package:flutter/material.dart';
import 'package:notes/entities/priority.dart';
import 'package:notes/ui/utils/priorities_colors.dart';

class NoteChipsInputs extends StatelessWidget {
  final String selectedValue;
  final Function onSelected;
  const NoteChipsInputs({
    Key key,
    @required this.selectedValue,
    @required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: Priority.values.map(
            (value) {
              final priority = Priorities.enumToString(value);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InputChip(
                  selected: this.selectedValue == priority,
                  backgroundColor:
                      PrioritiesColors.getColorByPriority(priority: value),
                  selectedColor: PrioritiesColors.getColorByPriority(
                    priority: value,
                    selected: true,
                  ),
                  checkmarkColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  onPressed: () => this.onSelected(priority),
                  label: Text(
                    priority,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
