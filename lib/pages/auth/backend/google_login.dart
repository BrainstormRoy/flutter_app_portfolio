import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portfolio_app/global/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to save user details in SharedPreferences
Future<void> saveUserDetails({
  required String firstName,
  required String email,
  String? lastName,
  String? phone,
  String? photoUrl,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('firstName', firstName);
  await prefs.setString('lastName', lastName ?? '');
  await prefs.setString('email', email);
  await prefs.setString('phone', phone ?? '');
  await prefs.setString('photoUrl', photoUrl ?? '');
}

// Google Sign-In function
Future<Map<String, dynamic>> googleSignIn() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return {
        'message': 'User canceled the sign-in process',
        'user_id': null,
      };
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      final String? displayName = user?.displayName;

      final List<String>? nameParts = splitFullName(displayName);

      final String? firstName =
          nameParts?.isNotEmpty == true ? nameParts![0] : null;
      final String? lastName =
          nameParts?.isNotEmpty == true ? nameParts!.last : null;

      final String? email = user?.email;
      final String? phoneNumber = user?.phoneNumber;
      final String? photoUrl = user?.photoURL;

      if (displayName != null && firstName != null && lastName != null) {
        await saveUserDetails(
          firstName: firstName,
          lastName: lastName,
          email: email ?? '',
          phone: phoneNumber ?? '',
          photoUrl: photoUrl ?? '',
        );
      }

      return {
        'message': 'Sign-in successful',
        'user_id': user?.uid,
      };
    } catch (e) {
      return {
        'message': 'Firebase sign-in error',
        'user_id': null,
      };
    }
  } catch (e) {
    return {
      'message': 'Google Sign-In error',
      'user_id': null,
    };
  }
}

Future<void> signOut(context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    await auth.signOut();
    await googleSignIn.signOut();
    customSnackBar(context, 'You have been logged out successfully!',
        Colors.grey.shade400, Colors.white);
  } catch (e) {
    customSnackBar(
        context, 'Error signing out: $e', Colors.grey.shade400, Colors.white);
  }
}

List<String>? splitFullName(String? fullName) {
  if (fullName == null) {
    return null;
  }

  List<String> nameParts = fullName.split(' ');

  nameParts = nameParts.map((part) => part.trim()).toList();

  return nameParts;
}
