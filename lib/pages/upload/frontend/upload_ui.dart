// color: Color(0xffFBFBFD),
// Color(0xffEE3A57),

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/global/functions/navigate_page.dart';
import 'package:portfolio_app/global/widgets/custom_snackbar.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:portfolio_app/pages/auth/frontend/login.dart';
import 'package:portfolio_app/pages/upload/frontend/home.dart';

import '../model/user_model.dart';
import '../backend/function/create_user.dart';
import '../../auth/backend/google_login.dart';
import '../../../global/widgets/custom_textfield.dart';
import '../../../global/widgets/loading_indicator.dart';

class UserUploadUi extends StatefulWidget {
  const UserUploadUi({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.twitter,
    required this.bio,
  });

  final String? firstName,
      lastName,
      username,
      email,
      phone,
      whatsapp,
      twitter,
      bio;

  @override
  State<UserUploadUi> createState() => _UserUploadUiState();
}

class _UserUploadUiState extends State<UserUploadUi> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _whatsapp = TextEditingController();
  final TextEditingController _twitter = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  bool showUsernameAvailability = false;
  bool usernameAvailable = true;
  bool isLoading = false;

  // setDetails() async {
  //   SharedPreferences prefs =
  //       await SharedPreferences.getInstance(); // ! .................
  //   setState(() {
  //     _firstName.text = prefs.getString('firstName')!;
  //     _lastName.text = prefs.getString('lastName')!;

  //     // Generate a random 6-digit number
  //     int randomNumber = Random().nextInt(900000) + 100000;
  //     final number = randomNumber.toString();
  //     _username.text = _lastName.text + _firstName.text + number;
  //     _email.text = prefs.getString('email')!; // !................
  //     _phone.text = prefs.getString('phone')!;
  //   });
  // }

  // Stream<List<Users>> retrieveUserFromFirebase(String? email) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .snapshots()
  //       .asyncMap(
  //     (snapshot) async {
  //       // return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  //       if (snapshot.docs.isNotEmpty) {
  //         final userData = snapshot.docs.first.data();

  //         // Extract data from the document and update the state
  //         _updateStateFromFirebase(userData);
  //         return snapshot.docs
  //             .map((doc) => Users.fromJson(doc.data()))
  //             .toList();
  //       } else {
  //         return setDetails();
  //       }
  //     },
  //   );
  // }

  // void _updateStateFromFirebase(Map<String, dynamic> userData) {
  //   setState(() {
  //     _firstName.text = userData['firstName'];
  //     _lastName.text = userData['lastName'];
  //     _username.text = userData['username'];
  //   });
  // }

  Stream<List<Users>> checkUsername(String username) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: username)
        .snapshots()
        .asyncMap((snapshot) async {
      return snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList();
    });
  }

  // setData() {
  //   setState(() {
  //     _firstName.text = widget.firstName!;
  //     _lastName.text = widget.lastName!;
  //     _username.text = widget.username!;
  //     _email.text = widget.email!;
  //     _phone.text = widget.phone!;
  //     _whatsapp.text = widget.whatsapp!;
  //     _twitter.text = widget.twitter!;
  //     _bio.text = widget.bio!;
  //   });
  // }

  @override
  void initState() {
    //  setData();
    // print(widget.firstName);
    setState(() {
      _firstName.text = widget.firstName!;
      _lastName.text = widget.lastName!;
      _username.text = widget.username!;
      _email.text = widget.email!;
      _phone.text = widget.phone!;
      _whatsapp.text = widget.whatsapp!;
      _twitter.text = widget.twitter!;
      _bio.text = widget.bio!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(color: Color(0xff1C1E33)),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.93,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText01(
                                text: 'Upload Data',
                                fontSize: 24.0,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                                color: Color(0xffFBFBFD),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                navigateFunc() {
                                  navigateToPage(
                                      context, const SocialLoginUi());
                                }

                                await signOut(context);
                                navigateFunc();
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Color(0xffFBFBFD),
                              ),
                            )
                          ],
                        ),
                        const Gap(28.0),

                        // ^ ================= Name =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText01(
                                  text: 'First Name',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xffFBFBFD),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.44,
                                  child: CustomTextField02(
                                    controller: _firstName,
                                    labelText: 'John',
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText01(
                                  text: 'Last Name',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xffFBFBFD),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.44,
                                  child: CustomTextField02(
                                    controller: _lastName,
                                    labelText: 'Doe',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // ^ ================= Name =================

                        const Gap(28.0),
                        // ^ ================= Username =================
                        const CustomText01(
                          text: 'Username',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _username,
                          labelText: 'johndoe',
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            setState(() {
                              _username.value = _username.value.copyWith(
                                text: value.toLowerCase(),
                                selection: TextSelection.collapsed(
                                    offset: value.length),
                              );
                              showUsernameAvailability = true;
                            });

                            // adding delay while calling the function
                            EasyDebounce.debounce(
                              'my-debouncer',
                              const Duration(milliseconds: 1000),
                              () async {
                                final userList =
                                    await checkUsername(_username.text.trim())
                                        .first;

                                setState(() {
                                  usernameAvailable = userList.isEmpty;
                                });
                              },
                            );
                          },
                        ),
                        const Gap(5.0),
                        showUsernameAvailability
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: CustomText01(
                                  text: usernameAvailable
                                      ? 'username available ✓'
                                      : 'username not available ✗',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w800,
                                  color: usernameAvailable
                                      ? const Color(0xff28A745)
                                      : const Color(0xffEE3A57),
                                ),
                              )
                            : const SizedBox(),

                        // ^ ================= Username =================

                        const Gap(28.0),
                        // ^ ================= Email =================
                        const CustomText01(
                          text: 'Email',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _email,
                          labelText: 'johndoe@gmail.com',
                          textInputType: TextInputType.emailAddress,
                        ),
                        // ^ ================= Email =================

                        const Gap(28.0),
                        // ^ ================= Phone =================
                        const CustomText01(
                          text: 'Phone',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _phone,
                          labelText: '+xxxxxxxxxxxx',
                          textInputType: TextInputType.phone,
                        ),
                        // ^ ================= Phone =================

                        const Gap(28.0),
                        // ^ ================= Whatsapp =================
                        const CustomText01(
                          text: 'WhatsApp',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _whatsapp,
                          labelText: 'xxxxxxxxxxxx',
                          textInputType: TextInputType.phone,
                        ),
                        // ^ ================= Whatsapp =================

                        const Gap(28.0),
                        // ^ ================= Twitter =================
                        const CustomText01(
                          text: 'Twitter',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _twitter,
                          labelText: '@johndoe',
                          textInputType: TextInputType.name,
                        ),
                        // ^ ================= Twitter =================

                        const Gap(28.0),
                        // ^ ================= Bio =================
                        const CustomText01(
                          text: 'Bio',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffFBFBFD),
                        ),
                        CustomTextField02(
                          controller: _bio,
                          labelText: 'Short Description',
                          maxLines: 5,
                          textInputType: TextInputType.multiline,
                        ),
                        // ^ ================= Bio =================

                        const Gap(28.0),
                        // ^ ================= Upload button =================
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: const Color(0xffEE3A57),
                            ),
                            onPressed: () async {
                              navigateFunc() {
                                navigateToPage(
                                    context, HomePage(email: _email.text));
                              }

                              if (_firstName.text.trim().isNotEmpty &&
                                  _lastName.text.trim().isNotEmpty &&
                                  _username.text.trim().isNotEmpty &&
                                  _email.text.trim().isNotEmpty &&
                                  _phone.text.trim().isNotEmpty &&
                                  _whatsapp.text.trim().isNotEmpty &&
                                  _twitter.text.trim().isNotEmpty &&
                                  _bio.text.trim().isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                final user = Users(
                                  firstName: _firstName.text.trim(),
                                  lastName: _lastName.text.trim(),
                                  userName: _username.text.trim(),
                                  email: _email.text.trim(),
                                  phone: int.tryParse(_phone.text.trim()) ?? 0,
                                  whatsApp:
                                      int.tryParse(_whatsapp.text.trim()) ?? 0,
                                  twitter: _twitter.text.trim(),
                                  bio: _bio.text.trim(),
                                );

                                //  createUser(user);

                                await createUser(user);
                                setState(() {
                                  isLoading = false;
                                });

                                // Clear the text field controllers
                                _firstName.clear();
                                _lastName.clear();
                                _username.clear();
                                _email.clear();
                                _phone.clear();
                                _whatsapp.clear();
                                _twitter.clear();
                                _bio.clear();
                                navigateFunc();
                              } else {
                                customSnackBar(
                                    context,
                                    'Fields Empty',
                                    const Color(0xffEE3A57),
                                    const Color(0xffFBFBFD));
                              }
                            },
                            child: const CustomText01(
                              text: 'Upload Data',
                              color: Color(0xffFBFBFD),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // ^ ================= Upload button =================
                        const Gap(28.0),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading) const LoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
