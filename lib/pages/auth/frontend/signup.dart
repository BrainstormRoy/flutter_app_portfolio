import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/pages/auth/frontend/login.dart';

import '../../../global/widgets/custom_text.dart';
import '../../../global/widgets/custom_textfield.dart';

class AppSignUpUi extends StatefulWidget {
  const AppSignUpUi({super.key});

  @override
  State<AppSignUpUi> createState() => _AppSignUpUiState();
}

class _AppSignUpUiState extends State<AppSignUpUi> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.93,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ! ================= container =================
                    const Gap(44.0),
                    // ! ================= login text =================
                    const Align(
                      alignment: Alignment.topLeft,
                      child: CustomText01(
                        text: 'Sign Up',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Color(0xffFBFBFD),
                      ),
                    ),
                    // ! ================= login text =================

                    // ! ================= form =================
                    const Gap(44.0),

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
                    ),
                    // ^ ================= Email =================

                    const Gap(28.0),
                    // ^ ================= Password =================
                    const CustomText01(
                      text: 'Password',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffFBFBFD),
                    ),
                    CustomTextField02(
                      controller: _password,
                      labelText: '************',
                      obscureText: isPasswordVisible,
                      widget: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(
                                Icons.visibility_off,
                                color: Color(0xffFBFBFD),
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Color(0xffFBFBFD),
                              ),
                      ),
                    ),
                    // ^ ================= Password =================

                    const Gap(28.0),
                    // ^ ================= confirm Password =================
                    const CustomText01(
                      text: 'Confirm Password',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffFBFBFD),
                    ),
                    CustomTextField02(
                      controller: _password,
                      labelText: '************',
                      obscureText: isConfirmPasswordVisible,
                      widget: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                        icon: isConfirmPasswordVisible
                            ? const Icon(
                                Icons.visibility_off,
                                color: Color(0xffFBFBFD),
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Color(0xffFBFBFD),
                              ),
                      ),
                    ),
                    // ^ ================= confirm Password =================

                    const Gap(40.0),

                    // ^ ================= Sign Up button =================
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
                        onPressed: () {},
                        child: const CustomText01(
                          text: 'Sign Up',
                          color: Color(0xffFBFBFD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ^ ================= Sign Up button =================

                    // ! ================= form =================

                    const Gap(40.0),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText01(
                          text: 'Don\'t have an account?',
                          color: Color(0xffFBFBFD),
                          fontSize: 14.0,
                        ),
                        const Gap(20.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AppLoginUi()));
                          },
                          child: const CustomText01(
                            text: 'Sign Up',
                            color: Color(0xffEE3A57),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
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
