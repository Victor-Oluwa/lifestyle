import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
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
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            // height: 30.h,
            child: UserImageAndButtons(
              user: widget.user,
              profileFunctions: widget.profileFunctions,
            ),
          ),

          SizedBox(height: 4.h),

          ordersText(),
          SizedBox(
            height: 25.h,
            // margin: EdgeInsets.only(bottom: 4.h),
            child: OrderPageView(
                ref: widget.ref, profileFunctions: widget.profileFunctions),
          ),
          // SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Align ordersText() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: EdgeInsets.only(right: 11.w),
          child: NeumorphicText(
              style: const NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  // border: NeumorphicBorder(width: 1),
                  shadowLightColor: Colors.black26,
                  intensity: 50,
                  depth: 1,
                  color: LifestyleColors.kTaupeBackground),
              textStyle: NeumorphicTextStyle(
                fontSize: 22.sp,
                fontFamily: LifestyleFonts.kComorantBold,
              ),
              'ORDERS')),
    );
  }
}
