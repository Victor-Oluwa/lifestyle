// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/components/user/Documents/screens/privacy_policy.dart';
import 'package:lifestyle/components/user/auth/screen/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';

import '../../../../Common/strings/strings.dart';
import '../../../../Common/widgets/floating_text_editor.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../provider/auth_provider.dart';

enum Auth { signIn, signUp }

bool registered = true;

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = 'auth-screen';

  @override
  ConsumerState<SignUpScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<SignUpScreen> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(() {
      setState(() {});
    });
    nameFocusNode.addListener(() {
      setState(() {});
    });

    passwordFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  Future<void> signUpUser() async {
    final authFunction = ref.read(authFunctionsProvider(context));
    authFunction.signUpUser(
        emailController: _emailController,
        passwordController: _passwordController,
        nameController: _nameController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0A291),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSignUpText(),
                    buildSignUpForm(),
                    SizedBox(
                      height: 5.h,
                    ),
                    buildSignUpButton(),
                    IconButton(
                        onPressed: () {
                          x.Get.to(() => const PrivacyPolicy(),
                              arguments:
                                  LifestyleStrings.privacyPolicyAssetPath);
                        },
                        icon: const MediumText(
                            decoration: TextDecoration.underline,
                            text: LifestyleStrings.termsAndPrivacy))
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                left: 25.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MediumText(
                      font: comorant,
                      text: 'Already have an account? ',
                      color: LifestyleColors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        x.Get.offAll(() => const LoginScreen());
                      },
                      icon: const MediumText(
                        text: 'Sign in',
                        color: LifestyleColors.kTaupeDarkened,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSignUpText() {
    return Padding(
      padding: EdgeInsets.only(top: 13.h, left: 4.w),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: MediumText(
          font: comorant,
          color: LifestyleColors.white,
          text: 'Sign Up',
          size: 32.sp,
        ),
      ),
    );
  }

  Form buildSignUpForm() {
    return Form(
      key: _signUpFormKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            buildNameEdittor(),
            SizedBox(
              height: 4.h,
            ),
            buildEmailEdittor(),
            SizedBox(
              height: 4.h,
            ),
            buildPasswordEdittor(),
          ],
        ),
      ),
    );
  }

  Widget buildNameEdittor() {
    return FloatingTextEditor(
      focusNode: nameFocusNode,
      controller: _nameController,
      label: const MediumText(
        text: 'Name',
        color: LifestyleColors.white,
      ),
      icon: const Icon(
        Icons.person_2_sharp,
        color: LifestyleColors.white,
      ),
      validate: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget buildEmailEdittor() {
    return FloatingTextEditor(
      focusNode: emailFocusNode,
      controller: _emailController,
      label: const MediumText(
        text: 'Email',
        color: LifestyleColors.white,
      ),
      icon: const Icon(
        Icons.email,
        color: LifestyleColors.white,
      ),
      validate: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$")
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget buildPasswordEdittor() {
    return FloatingTextEditor(
      obscureText: _obscureText,
      focusNode: passwordFocusNode,
      controller: _passwordController,
      label: const MediumText(
        text: 'Password',
        color: LifestyleColors.white,
      ),
      icon: const Icon(
        Icons.lock,
        color: LifestyleColors.white,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _toggleVisibility();
          });
        },
        icon: _obscureText
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
      ),
      validate: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }

  Padding buildSignUpButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: (() {
          if (_signUpFormKey.currentState!.validate()) {
            signUpUser();
          }
        }),
        //Conditionally main sign in or Sign up button
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: LifestyleColors.kTaupeDarkened,
                borderRadius: BorderRadius.circular(5.sp)),
            height: 7.h,
            width: 90.w,
            child: MediumText(
              font: comorant,
              color: LifestyleColors.white,
              text: 'Sign Up',
            )),
      ),
    );
  }
}
