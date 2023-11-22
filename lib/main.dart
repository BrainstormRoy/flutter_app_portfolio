import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/global/theme/theme.dart';
import 'package:portfolio_app/pages/upload/frontend/home.dart';
import 'package:portfolio_app/pages/upload/frontend/test_home.dart';

import 'pages/auth/frontend/auth.dart';
import 'pages/auth/frontend/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    // authService.isLoggedIn();
    // final user = authService.currentUser!.email;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: lightMode,
      // darkTheme: darkMode,
      home: FutureBuilder<bool>(
        future: authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Still checking the authentication status
            return const CircularProgressIndicator();
          } else {
            // Check if the user is logged in
            final bool isLoggedIn = snapshot.data ?? false;

            // if (isLoggedIn) {
            //   final userEmail = authService.currentUser!.email;
            // }

            // Return the appropriate screen based on the authentication status
            return isLoggedIn
                // ? UserUploadUi(email: user)
                ? HomePageTest(
                    email: authService.currentUser!.email ?? 'johndoe')
                : const SocialLoginUi();
          }
        },
      ),
    );
  }
}
// SharedPreferences prefs =
        // await SharedPreferences.getInstance(); 