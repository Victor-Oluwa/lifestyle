import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/user.dart';
import '../function/profile_functions.dart';
import 'main_order_view.dart';
import 'user_image_and_side_icon_widget.dart';

class ProfileMainBody extends StatefulWidget {
  const ProfileMainBody({
    Key? key,
    required this.ref,
    required this.user,
    required this.profileFunctions,
  }) : super(key: key);
  final WidgetRef ref;
  final User user;
  final ProfileFunctions profileFunctions;

  @override
  State<ProfileMainBody> createState() => _ProfileMainBodyState();
}

class _ProfileMainBodyState extends State<ProfileMainBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 11.w),
                      child: MediumText(
                        font: LifestyleFonts.kComorantBold,
                        text: 'Track your orders',
                        size: 20.sp,
                        color: LifestyleColors.kTaupeDarkened,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: LifestyleColors.kTaupeDarkened,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  OrderPageViewWidget(
                      ref: widget.ref,
                      profileFunctions: widget.profileFunctions),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ),
          UserImageAndSideIconWidget(
            user: widget.user,
            profileFunctions: widget.profileFunctions,
          )
        ],
      ),
    );
  }
}
