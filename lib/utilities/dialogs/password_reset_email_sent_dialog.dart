import 'package:flutter/material.dart';
import 'package:second_tutorial/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Password reset",
    content:
        "Your password reset link has been sent out. Please check your emails for more details!",
    optionBuilder: () => {"OK": null},
  );
}
