import 'package:flutter/material.dart';
import 'package:second_tutorial/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete note",
    content: "Are you sure you want to delete this note?",
    optionBuilder: () => {
      "Cancel": false,
      "Delete": true,
    },
  ).then((value) => value ?? false);
}
