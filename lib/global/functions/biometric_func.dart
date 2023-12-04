import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:portfolio_app/global/widgets/custom_snackbar.dart';

final LocalAuthentication auth = LocalAuthentication();

Future<bool> authenticateWithBiometrics(context) async {
  bool authenticated = false;

  try {
    authenticated = await auth.authenticate(
      localizedReason: 'Please authenticate for secure access',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
    );
  } on PlatformException {
    customSnackBar(
      context,
      'Biometric authentication not enabled',
      Colors.red.shade400,
      Colors.white,
    );
    return false;
  }

  final bool result = authenticated ? true : false;

  return result;
}
