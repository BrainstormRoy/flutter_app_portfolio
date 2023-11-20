import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:portfolio_app/global/widgets/custom_textfield.dart';
import 'package:portfolio_app/pages/auth/frontend/signup.dart';

class AppLoginUi extends StatefulWidget {
  const AppLoginUi({super.key});

  @override
  State<AppLoginUi> createState() => _AppLoginUiState();
}

class _AppLoginUiState extends State<AppLoginUi> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ! ================= container =================
                    const Gap(44.0),
                    // ! ================= login text =================
                    const Align(
                      alignment: Alignment.topLeft,
                      child: CustomText01(
                        text: 'Log-in',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Color(0xffFBFBFD),
                      ),
                    ),
                    // ! ================= login text =================

                    const Gap(40.0),

                    // ! ================= Main Body =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ^ ================= email id =================
                          const CustomText01(
                            text: 'Email',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffFBFBFD),
                          ),
                          CustomTextField02(
                            controller: _emailController,
                            labelText: 'johndoe@gmail.com',
                          ),
                          // ^ ================= email id =================

                          const Gap(18.0),

                          // ^ ================= password =================
                          const CustomText01(
                            text: 'Password',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffFBFBFD),
                          ),
                          CustomTextField02(
                            controller: _passwordController,
                            labelText: '**************',
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

                          const Gap(4.0),

                          InkWell(
                            onTap: () {},
                            child: const Align(
                              alignment: Alignment.bottomRight,
                              child: CustomText01(
                                text: 'Forgot Password?',
                                color: Color(0xffEE3A57),
                              ),
                            ),
                          ),
                          // ^ ================= password =================

                          const Gap(24.0),

                          // ^ ================= login button =================
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const UserUploadUi(),
                                //   ),
                                // );
                              },
                              child: const CustomText01(
                                text: 'Login',
                                color: Color(0xffFBFBFD),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // ^ ================= login button =================
                        ],
                      ),
                    ),
                    // ! ================= container =================
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          const CustomText01(
                            text: 'Or Sign in with',
                            color: Color(0xffFBFBFD),
                            fontSize: 14.0,
                            letterSpacing: 2,
                          ),
                          const Gap(8.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Card(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Card(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Card(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ],
                          ),
                          const Gap(12.0),
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
                                          builder: (context) =>
                                              const AppSignUpUi()));
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
