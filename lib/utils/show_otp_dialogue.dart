import 'package:flutter/material.dart';

void showOtpDialogue({
  required BuildContext context,
  required TextEditingController otpController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Enter OTP"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: otpController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text("Done"),
        ),
      ],
    ),
  );
}
