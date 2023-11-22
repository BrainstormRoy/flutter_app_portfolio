import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:portfolio_app/global/functions/navigate_page.dart';
import 'package:portfolio_app/pages/upload/frontend/upload_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:gap/gap.dart';

import '../../auth/backend/google_login.dart';
import '../model/user_model.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<Users?> userDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture = retrieveUserData(widget.email);
  }

  Future<Users?> retrieveUserData(String userEmail) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return Users.fromJson(snapshot.docs.first.data());
      }
    } catch (e) {
      // Handle errors if any
      debugPrint('Error fetching user data: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: const Color(0xff1C1E33),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppBar(),
                  FutureBuilder<Users?>(
                    future: userDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return buildLoadingIndicator();
                      }
                      if (snapshot.hasError) {
                        return buildErrorWidget();
                      }
                      if (snapshot.data == null) {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        User? googleUser = auth.currentUser;
                        return buildNewUserPrompt(googleUser);
                      }
                      return buildUserProfile(snapshot.data!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 50.0),
        IconButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          icon: const Icon(Icons.logout, color: Colors.amber),
        ),
      ],
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorWidget() {
    return const Center(
      child: Text('Error loading user data.'),
    );
  }

  Widget buildNewUserPrompt(User? googleUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.40,
          child: LottieBuilder.network(
              'https://lottie.host/a05b8c07-e183-43d7-9fa8-5ec2c134fef4/2RrzV9C5jX.json'),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomText01(
            text: googleUser!.displayName!,
            color: const Color(0xffFBFBFD),
            fontSize: 24.0,
            letterSpacing: 2,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomText01(
            text: googleUser.email!,
            color: const Color(0xffFBFBFD),
            fontSize: 16.0,
            letterSpacing: 1,
          ),
        ),
        const Gap(20.0),
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: const Color(0xffEE3A57)),
            onPressed: () async {
              String x = googleUser.displayName!;

              List<String>? nameParts = splitFullName(x);

              final String? fName =
                  nameParts?.isNotEmpty == true ? nameParts![0] : null;
              final String? lastName =
                  nameParts?.isNotEmpty == true ? nameParts!.last : null;

              navigateToPage(
                context,
                UserUploadUi(
                  firstName: fName,
                  lastName: lastName ?? '',
                  username: '',
                  email: googleUser.email,
                  phone: '',
                  whatsapp: '',
                  twitter: '',
                  bio: '',
                  dpUrl: '',
                ),
              );
            },
            child: const CustomText01(
              text: 'Complete Details to continue',
              fontSize: 14.0,
              color: Color(0xffFBFBFD),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUserProfile(Users user) {
    return Column(
      children: [
        // ! -------------------- display picture --------------------
        Container(
          height: MediaQuery.sizeOf(context).height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                image: NetworkImage(user.dpUrl), fit: BoxFit.cover),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY:
                      5), // Adjust sigmaX and sigmaY for the desired blur intensity
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.1),
                      const Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.5),
                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Image.network(user.dpUrl),
              ),
            ),
          ),
        ),

        // ! -------------------- display picture --------------------

        const Gap(16.0),
        // * full name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  CustomText01(
                    text: user.firstName,
                    color: Colors.white,
                    fontSize: 24.0,
                    letterSpacing: 1,
                  ),
                  const Gap(10),
                  CustomText01(
                    text: user.lastName,
                    color: Colors.white,
                    fontSize: 24.0,
                    letterSpacing: 1,
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                navigateToPage(
                  context,
                  UserUploadUi(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    username: user.userName,
                    email: user.email,
                    phone: user.phone.toString(),
                    whatsapp: user.whatsApp.toString(),
                    twitter: user.twitter,
                    bio: user.bio,
                    dpUrl: user.dpUrl,
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),

        // * username
        CustomText01(
          text: user.userName,
          color: Colors.white,
          fontSize: 16.0,
          letterSpacing: 1,
        ),
        const Gap(16.0),

        // * contact card
        Card(
          elevation: 5,
          // color: Colors.grey.shade300,
          child: SizedBox(
            width: (MediaQuery.sizeOf(context).height * 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ^ call
                IconButton(
                  onPressed: () {
                    void launchCall(number) async {
                      final Uri phoneNumber = Uri.parse('tel:$number');
                      launchUrl(phoneNumber);
                    }

                    launchCall(user.phone);
                  },
                  icon: SizedBox(
                    height: 30.0,
                    child: Image.asset(
                      'assets/icons/call.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // ^ work

                // ^ email
                IconButton(
                  onPressed: () {
                    void launchEmail(String emailId) async {
                      final Uri email = Uri(
                        scheme: 'mailto',
                        path: emailId,
                        queryParameters: {},
                      );
                      launchUrl(email, mode: LaunchMode.externalApplication);
                    }

                    launchEmail(user.email);
                  },
                  icon: SizedBox(
                    height: 30.0,
                    child: Image.asset(
                      'assets/icons/gmail.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // ^ whatsapp
                IconButton(
                  onPressed: () {
                    void launchWhatsApp(number) async {
                      final Uri whatsApp = Uri.parse('https://wa.me/$number?');
                      launchUrl(whatsApp, mode: LaunchMode.externalApplication);
                    }

                    launchWhatsApp(user.whatsApp);
                  },
                  icon: SizedBox(
                    height: 28.0,
                    child: Image.asset(
                      'assets/icons/whatsapp.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // ^ twitter
                IconButton(
                  onPressed: () {
                    void launchTwitterProfile(String username) async {
                      final Uri twitterProfile =
                          Uri.parse('https://twitter.com/$username');
                      launchUrl(twitterProfile,
                          mode: LaunchMode.externalApplication);
                    }

                    launchTwitterProfile(user.twitter);
                  },
                  icon: SizedBox(
                    height: 28.0,
                    child: Image.asset(
                      'assets/icons/twitter.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // * bio
        const Gap(16.0),
        // *bio

        CustomText01(
          text: user.bio,
          color: Colors.white,
          fontSize: 16.0,
          letterSpacing: 1,
        ),
      ],
    );
    // Build the user profile UI
  }

  // Rest of your UI building methods...
}
