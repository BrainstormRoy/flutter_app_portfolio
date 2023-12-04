// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:portfolio_app/global/functions/navigate_page.dart';

// import '../auth/frontend/auth.dart';
// import '../auth/frontend/login.dart';
// import '../home/frontend/home.dart';

// class TestTogglePage extends StatefulWidget {
//   const TestTogglePage({super.key});

//   @override
//   State<TestTogglePage> createState() => _TestTogglePageState();
// }

// class _TestTogglePageState extends State<TestTogglePage> {
//   final AuthService authService = AuthService();

//   final LocalAuthentication auth = LocalAuthentication();
//   _SupportState _supportState = _SupportState.unknown;
//   List<BiometricType>? _availableBiometrics;

//   // ! authenticate function
//   Future<void> _authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: 'Please authenticate for secure access',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: false,
//         ),
//       );
//     } on PlatformException catch (e) {
//       print(e);

//       return;
//     }
//   }

//   // ! find list of available biometrics
//   Future<void> _getAvailableBiometrics() async {
//     late List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       availableBiometrics = <BiometricType>[];
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });

//     if (_availableBiometrics!.isNotEmpty) {
//       _authenticateWithBiometrics();
//     } else {
//       navigateToPage(context,
//           HomePage(email: authService.currentUser!.email ?? 'johndoe'));
//     }
//   }

//   // ! is device supported or not
//   initialFunciton() async {
//     await auth.isDeviceSupported().then(
//           (bool isSupported) => setState(() => _supportState = isSupported
//               ? _SupportState.supported
//               : _SupportState.unsupported),
//         );
//     _getAvailableBiometrics();
//     // _authenticateWithBiometrics();
//   }

//   @override
//   void initState() {
//     initialFunciton();
//     super.initState();
//   }

// // ***************************************

// // ***************************************

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: authService.isLoggedIn(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Still checking the authentication status
//           return const CircularProgressIndicator();
//         } else {
//           // Check if the user is logged in
//           final bool isLoggedIn = snapshot.data ?? false;
//           //
//           return isLoggedIn
//               ? HomePage(email: authService.currentUser!.email ?? 'johndoe')
//               : const SocialLoginUi();
//         }
//       },
//     );
//   }
// }

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
