// color: Color(0xffFBFBFD),
// Color(0xffEE3A57),
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:portfolio_app/pages/upload/frontend/upload_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import '../../../global/functions/navigate_page.dart';
import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? firstName = '';
  String? lastName;
  String? userName;
  String? bio;
  String? email;
  int? phone;
  String? twitter;
  int? whatsapp;

  bool newUser = true;

  Stream<List<Users>> retrieveData(String userEmail) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: 'gaurabroy.kyptronix@gmail.com')
        .snapshots()
        .asyncMap((snapshot) async {
      return snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList();
    });
  }

  getData(String userEmail) async {
    final isData = await retrieveData(userEmail).first;

    if (isData.isNotEmpty) {
      setState(() {
        newUser = false;
      });
      final userList = await retrieveData(userEmail).first;

      if (userList.isNotEmpty) {
        setState(() {
          firstName = userList.first.firstName;
          lastName = userList.first.lastName;
          userName = userList.first.userName;
          bio = userList.first.bio;
          email = userList.first.email;
          phone = userList.first.phone;
          twitter = userList.first.twitter;
          whatsapp = userList.first.whatsApp;
        });
      }
    } else {
      setState(() {
        newUser = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      User? googleUser = auth.currentUser;
      setState(() {
        firstName = googleUser!.displayName!;
        userName = googleUser.email;
        // bio = userList.first.bio;
        email = googleUser.email;
        phone = googleUser.phoneNumber as int?;
      });
    }
  }

  @override
  void initState() {
    getData(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(0xff1C1E33),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.infinity,
                  color: Colors.white,
                ),
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
                            text: firstName ?? '',
                            color: Colors.white,
                            fontSize: 24.0,
                            letterSpacing: 1,
                          ),
                          const Gap(10),
                          CustomText01(
                            text: lastName ?? '',
                            color: Colors.white,
                            fontSize: 24.0,
                            letterSpacing: 1,
                          ),
                        ],
                      ),
                    ),
                    newUser
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () async {
                              navigateToPage(
                                context,
                                UserUploadUi(
                                  firstName: firstName,
                                  lastName: lastName,
                                  username: userName,
                                  email: email,
                                  phone: phone.toString(),
                                  whatsapp: whatsapp.toString(),
                                  twitter: twitter,
                                  bio: bio,
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
                  text: userName ?? '',
                  color: Colors.white,
                  fontSize: 16.0,
                  letterSpacing: 1,
                ),
                const Gap(16.0),

                // * contacts
                newUser
                    ? const SizedBox()
                    : Card(
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
                                    final Uri phoneNumber =
                                        Uri.parse('tel:$number');
                                    launchUrl(phoneNumber);
                                  }

                                  launchCall(phone);
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
                                    launchUrl(email,
                                        mode: LaunchMode.externalApplication);
                                  }

                                  launchEmail(email!);
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
                                    final Uri whatsApp =
                                        Uri.parse('https://wa.me/$number?');
                                    launchUrl(whatsApp,
                                        mode: LaunchMode.externalApplication);
                                  }

                                  launchWhatsApp(whatsapp);
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
                                  void launchTwitterProfile(
                                      String username) async {
                                    final Uri twitterProfile = Uri.parse(
                                        'https://twitter.com/$username');
                                    launchUrl(twitterProfile,
                                        mode: LaunchMode.externalApplication);
                                  }

                                  launchTwitterProfile(twitter!);
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

                const Gap(16.0),
                // *bio
                newUser
                    ? Column(
                        children: [
                          LottieBuilder.network(
                              'https://lottie.host/a05b8c07-e183-43d7-9fa8-5ec2c134fef4/2RrzV9C5jX.json'),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffEE3A57)),
                              onPressed: () async {
                                String x = firstName!;

                                List<String>? nameParts = splitFullName(x);

                                final String? fName =
                                    nameParts?.isNotEmpty == true
                                        ? nameParts![0]
                                        : null;
                                final String? lastName =
                                    nameParts?.isNotEmpty == true
                                        ? nameParts!.last
                                        : null;

                                navigateToPage(
                                  context,
                                  UserUploadUi(
                                      firstName: fName,
                                      lastName: lastName ?? '',
                                      username: '',
                                      email: email,
                                      phone: '',
                                      whatsapp: '',
                                      twitter: '',
                                      bio: ''),
                                );
                              },
                              child: const CustomText01(
                                text: 'Complete Details to continue',
                                fontSize: 14.0,
                                color: Color(0xffFBFBFD),
                              )),
                        ],
                      )
                    : CustomText01(
                        text: bio ?? '',
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: const Color(0xffEE3A57),
              ),
              onPressed: () {},
              child: const Text(
                'Log Out',
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
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
