import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  googleLogin(context) async {
    Map<String, dynamic> response = await AuthService().signInWithGoogle();

    if (response['message'] ==
        'Account with the same email ID already exists') {
      setState(() {
        // isGoogleLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response['user_id']);
      setState(() {
        userId = prefs.getString('userId')!;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserHome(userId: userId),
        ),
      );
    } else if (response['message'] == 'Account created successfully') {
      setState(() {
        isGoogleLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response['user_id']);
      setState(() {
        userId = prefs.getString('userId')!;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserHome(userId: userId),
        ),
      );
    } else {
      setState(() {
        isGoogleLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response['user_id']);
      setState(() {
        userId = prefs.getString('userId')!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Oops an error occurred. Try again!'),
          duration: const Duration(
              seconds:
                  5), // Specify the duration for which the Snackbar will be displayed
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
