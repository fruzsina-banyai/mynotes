import 'package:flutter/widgets.dart';
import 'package:second_tutorial/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sharing",
    content: "You cannot share an empty note!",
    optionBuilder: () => {
      "OK": null,
    },
  );
}
