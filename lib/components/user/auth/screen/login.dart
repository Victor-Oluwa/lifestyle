import 'package:flutter/material.dart';
import 'package:get/get.dart' as x;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../common/widgets/medium_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSignInScreen extends ConsumerStatefulWidget {
  const AuthSignInScreen({super.key});
  static const String routeName = '/sign-in-creen';

  @override
  ConsumerState<AuthSignInScreen> createState() => _AuthSignInScreenState();
}

class _AuthSignInScreenState extends ConsumerState<AuthSignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> signInUser() async {
    final authServices = ref.read(authServiceProvider);
    await authServices
        .signInUser(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then(
          (value) async =>
              await ref.read(notificationFunctionProvider).uploadFcmToken(),
        );
  }

  // Future<void> signIn() async {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
  //     if (event == ConnectivityResult.none) {
  //       x.Get.showSnackbar(const GetSnackBar(
  //         title: 'ATTENTION',
  //         message: 'Connect to the internet and try again',
  //       ));
  //     } else {
  //       // await  signInUser();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0A291),
      // resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.w),
                  decoration: const BoxDecoration(),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: MediumText(
                      font: comorant,
                      color: Colors.white,
                      text: 'Log in',
                      size: 32.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!RegExp(
                                    r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: MediumText(text: 'Email'),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              label: const MediumText(text: 'Password'),
                              suffixIcon: IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (_signInFormKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.sp)),
                    height: 7.h,
                    width: 90.w,
                    child: MediumText(
                      font: comorant,
                      color: Colors.white,
                      text: 'Sign In',
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                MediumText(
                  font: comorant,
                  text: 'Don\'t have an account?',
                  color: Colors.white,
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                    onTap: () {
                      x.Get.toNamed(LifestyleRouteName.signUpRoute);
                      // Navigator.pushNamed(context, AuthScreen.routeName);
                    },
                    child: MediumText(
                      font: comorant,
                      text: 'Register now?',
                      color: Colors.white,
                    ))
                // GestureDetector(
                //   onTap: () {
                //     authService.getUserData(context: context);
                //   },
                //   child: Container(
                //     margin: EdgeInsets.only(top: 5.h),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(15.sp)),
                //     height: 7.h,
                //     width: 90.w,
                //     child: const MediumText(
                //       text: 'Get user data',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
