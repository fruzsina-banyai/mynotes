import 'package:flutter/widgets.dart';
import 'package:second_tutorial/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Log out",
    content: "Are you sure you want to log out?",
    optionBuilder: () => {
      "Cancel": false,
      "Log out": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
