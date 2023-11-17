import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio_app/global/functions/navigate_page.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../upload/frontend/upload_ui.dart';
import '../backend/google_login.dart';

class SocialLoginUi extends StatefulWidget {
  const SocialLoginUi({super.key});

  @override
  State<SocialLoginUi> createState() => _SocialLoginUiState();
}

class _SocialLoginUiState extends State<SocialLoginUi> {
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
                    // const Align(
                    //   alignment: Alignment.topLeft,
                    //   child: CustomText01(
                    //     text: 'Log-in',
                    //     fontSize: 24.0,
                    //     fontWeight: FontWeight.w900,
                    //     letterSpacing: 2,
                    //     color: Color(0xffFBFBFD),
                    //   ),
                    // ),
                    // ! ================= login text =================

                    // ! ================= log in with google =================
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
                          // function to avoid build context error
                          navigateFunc() {
                            navigateToPage(context, const UserUploadUi());
                          }

                          final x = await googleSignIn();
                          if (x['message'] == 'Sign-in successful') {
                            navigateFunc();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/google_logo.svg',
                              height: 30.0,
                              colorFilter: const ColorFilter.mode(
                                Color(0xffFBFBFD),
                                BlendMode.srcIn,
                              ),
                            ),
                            const Gap(20.0),
                            const CustomText01(
                              text: 'Login with Google',
                              color: Color(0xffFBFBFD),
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(40.0),

                    // ! ================= log in with apple =================
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
                          signOut(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const UserUploadUi(),
                          //   ),
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/apple_logo.svg',
                              height: 30.0,
                              colorFilter: const ColorFilter.mode(
                                Color(0xffFBFBFD),
                                BlendMode.srcIn,
                              ),
                            ),
                            const Gap(20),
                            const CustomText01(
                              text: 'Login with Apple',
                              color: Color(0xffFBFBFD),
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ! ================= container =================
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
