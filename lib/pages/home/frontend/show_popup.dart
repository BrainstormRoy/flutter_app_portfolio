import 'package:flutter/material.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';

Future<void> showPopupOnPageLoad(context) async {
  await Future.delayed(
      Duration.zero); // Schedule the dialog to be shown after the first frame
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const CustomText01(text: 'App is locked'),
        content: const CustomText01(
            text: 'Authentication is required to access the app'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const CustomText01(text: 'Unlock'),
          ),
        ],
      );
    },
  );
}
