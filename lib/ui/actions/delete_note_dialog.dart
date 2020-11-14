import 'package:flutter/material.dart';

class DeleteNoteDialog {
  static showDeleteNoteDialog(
    BuildContext context,
    String title,
    String content,
    List<Widget> actions,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black),
          ),
          actions: actions,
        );
      },
    );
  }
}
