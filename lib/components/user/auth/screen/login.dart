import 'package:flutter/material.dart';
import 'package:get/get.dart' as x;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/floating_text_editor.dart';
import 'package:lifestyle/components/user/auth/provider/auth_provider.dart';
import 'package:lifestyle/components/user/auth/screen/signup.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../common/widgets/medium_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _AuthSignInScreenState();
}

class _AuthSignInScreenState extends ConsumerState<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> signInUser() async {
    final authFunctions = ref.read(authFunctionsProvider(context));
    await authFunctions.signInUser(
        emailController: _emailController,
        passwordController: _passwordController);
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
                  children: [
                    buildSignInText(),
                    buildSignInForm(),
                    SizedBox(
                      height: 5.h,
                    ),
                    buildSignInButton(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                left: 25.w,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MediumText(
                        font: comorant,
                        text: 'Don\'t have an account? ',
                        color: LifestyleColors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          x.Get.offAll(() => const SignUpScreen());
                        },
                        icon: MediumText(
                          font: comorant,
                          text: 'Sign up',
                          color: LifestyleColors.kTaupeDarkened,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignInText() {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 13.h),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: MediumText(
          font: comorant,
          color: LifestyleColors.white,
          text: 'Log in',
          size: 32.sp,
        ),
      ),
    );
  }

  GestureDetector buildSignInButton() {
    return GestureDetector(
      onTap: () {
        if (_signInFormKey.currentState!.validate()) {
          signInUser();
        }
      },
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
          text: 'Sign In',
        ),
      ),
    );
  }

  Container buildSignInForm() {
    return Container(
      margin: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
            buildNameTextEditor(),
            SizedBox(
              height: 3.h,
            ),
            buildPasswordTextEditor(),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordTextEditor() {
    return FloatingTextEditor(
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
      obscureText: _obscureText,
      suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility();
            });
          },
          icon: _obscureText
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility)),
      validate: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget buildNameTextEditor() {
    return FloatingTextEditor(
      focusNode: emailFocusNode,
      controller: _emailController,
      label: const MediumText(
        text: 'Email',
        color: LifestyleColors.white,
      ),
      icon: const Icon(
        Icons.person_2_sharp,
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
}
