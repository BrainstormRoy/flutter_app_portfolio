// color: Color(0xffFBFBFD),
// Color(0xffEE3A57),
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:portfolio_app/pages/upload/frontend/retrieve_data.dart';

import '../../../global/widgets/custom_textfield.dart';
import '../backend/function/create_user.dart';
import '../model/user_model.dart';

class UserUploadUi extends StatefulWidget {
  const UserUploadUi({super.key});

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

  bool usernameAvailable = true;
  // TODO:final Debouncer _debouncer = Debouncer(milliseconds: 500);

  Stream<List<User>> checkUsername(String username) =>
      FirebaseFirestore.instance
          .collection('users')
          .where('userName', isEqualTo: username)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(color: Color(0xff1C1E33)),
          child: Padding(
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
                              width: MediaQuery.sizeOf(context).width * 0.44,
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
                              width: MediaQuery.sizeOf(context).width * 0.44,
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
                      onChanged: (value) {
                        checkUsername(_username.text.trim()).listen((userList) {
                          // Check if the user exists in the userList

                          if (userList.isNotEmpty) {
                            setState(() {
                              usernameAvailable = false;
                            });
                          } else {
                            setState(() {
                              usernameAvailable = true;
                            });
                          }
                        });
                      },
                    ),
                    Align(
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
                    ),

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
                      textInputType: TextInputType.number,
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
                      textInputType: TextInputType.number,
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
                      textInputType: TextInputType.url,
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
                        onPressed: () {
                          final user = User(
                            // id: docUser.id,
                            firstName: 'John',
                            lastName: 'Doe',
                            userName: 'johndoe',
                            email: 'john.doe@example.com',
                            phone: 1234567890,
                            whatsApp: 987654321,
                            twitter: '@johndoe',
                            bio: 'A brief bio about John Doe.',
                          );
                          createUser(user);
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
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShowUserData(),
                            ),
                          );
                        },
                        child: const Text('data')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
