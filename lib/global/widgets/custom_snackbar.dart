import 'package:flutter/material.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    context, message, color, textColor) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText01(text: message, fontSize: 14.0, color: textColor),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: textColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
