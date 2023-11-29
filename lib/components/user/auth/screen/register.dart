import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Common/widgets/medium_text.dart';
import 'package:get/get.dart' as x;

enum Auth { signIn, signUp }

bool registered = true;

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = 'auth-screen';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
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

  void signUpUser() async {
    final authServices = ref.read(authServiceProvider);
    await authServices
        .signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          context: context,
        )
        .then(
          (value) async =>
              await ref.read(notificationFunctionProvider).uploadFcmToken(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0A291),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Form(
                  key: _signUpFormKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: MediumText(
                            font: comorant,
                            color: Colors.white,
                            text: 'Sign Up',
                            size: 32.sp,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        buildNameEdittor(),
                        SizedBox(
                          height: 3.h,
                        ),
                        buildEmailEdittor(),
                        SizedBox(
                          height: 3.h,
                        ),
                        buildPasswordEdittor(),
                      ],
                    ),
                  ),
                ),
                //After the form
                SizedBox(
                  height: 3.h,
                ),
                Padding(
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
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.sp)),
                        height: 7.h,
                        width: 90.w,
                        child: MediumText(
                          font: comorant,
                          color: Colors.white,
                          text: 'Sign Up',
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                MediumText(
                  font: comorant,
                  text: 'Do you have an account?',
                  color: Colors.white,
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                  onTap: () {
                    x.Get.toNamed(LifestyleRouteName.signInRoute);
                  },
                  child: MediumText(
                    font: comorant,
                    text: 'Login in instead',
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material buildNameEdittor() {
    return Material(
      animationDuration: Duration(seconds: 1),
      color: LifestyleColors.kTaupeBackground,
      borderRadius: BorderRadius.circular(8.sp),
      elevation: nameFocusNode.hasFocus ? 25.sp : 5.sp,
      shadowColor: Colors.grey,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        // color: LifestyleColors.kTaupeDarkened,
        height: 7.5.h,
        padding: EdgeInsets.only(top: 16.sp, bottom: 14.sp, left: 2.w),
        child: TextFormField(
          focusNode: nameFocusNode,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          keyboardType: TextInputType.name,
          controller: _nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            icon: const Icon(Icons.person_2,
                color: LifestyleColors.kTaupeDarkened),
            fillColor: LifestyleColors.kTaupeDarkened,
            filled: false,
            hintStyle: const TextStyle(color: LifestyleColors.black),
            label: const MediumText(text: 'Name'),
          ),
        ),
      ),
    );
  }

  Material buildEmailEdittor() {
    return Material(
      color: LifestyleColors.kTaupeBackground,
      animationDuration: Duration(seconds: 1),
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(8.sp),
      elevation: emailFocusNode.hasFocus ? 25.sp : 5.sp,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: 7.5.h,
        padding: EdgeInsets.only(top: 16.sp, bottom: 14.sp, left: 2.w),
        child: TextFormField(
          focusNode: emailFocusNode,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$")
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.sp))),
            fillColor: LifestyleColors.kTaupeBackground,
            icon:
                const Icon(Icons.email, color: LifestyleColors.kTaupeDarkened),
            filled: false,
            label: const MediumText(text: 'Email'),
          ),
        ),
      ),
    );
  }

  Material buildPasswordEdittor() {
    return Material(
      animationDuration: Duration(seconds: 1),
      color: LifestyleColors.kTaupeBackground,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(8.sp),
      elevation: passwordFocusNode.hasFocus ? 25.sp : 5.sp,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: 7.5.h,
        padding: EdgeInsets.only(top: 16.sp, bottom: 14.sp, left: 2.w),
        child: TextFormField(
          focusNode: passwordFocusNode,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }

            return null;
          },
          obscureText: _obscureText,
          controller: _passwordController,
          decoration: InputDecoration(
              fillColor: LifestyleColors.kTaupeBackground,
              filled: false,
              icon:
                  const Icon(Icons.lock, color: LifestyleColors.kTaupeDarkened),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7.sp))),
              label: const MediumText(text: 'Password'),
              suffixIcon: IconButton(
                  onPressed: _toggleVisibility,
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility))),
        ),
      ),
    );
  }
}
