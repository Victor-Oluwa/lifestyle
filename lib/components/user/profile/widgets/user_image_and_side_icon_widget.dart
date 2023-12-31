// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/components/admin/admin-tab/admin_tab.dart';
import 'package:lifestyle/components/user/cart/widgets/detailsConfirmation/edit_details_dialog.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/user.dart';
import '../../../../routes-management/lifestyle_routes_names.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../home/widgets/cart_badge_widget.dart';
import '../function/profile_functions.dart';
import '../screens/user_details_screen.dart';

class UserImageAndButtons extends ConsumerWidget {
  const UserImageAndButtons({
    Key? key,
    required this.profileFunctions,
    required this.user,
  }) : super(key: key);

  final ProfileFunctions profileFunctions;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Stack(
        // fit: StackFit.expand,
        children: [
          buildUserImage(context),
          buildSideIcons(context, ref),
          Align(
            alignment: Alignment.bottomRight,
            // bottom: 0.001.h,
            child: Padding(
              padding: EdgeInsets.only(right: 3.5.w),
              child: IconButton(
                  onPressed: () {
                    Get.offAll(() => const AdminTab());
                  },
                  icon: sideIcons(Icons.switch_account_outlined)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserImage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        curve: Curves.fastOutSlowIn,
        transform: Matrix4.translationValues(0.0, 0, 0),
        margin: EdgeInsets.only(right: 8.5.h),
        // padding: EdgeInsets.only(bottom: 30.h),
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.sp),
          ),
          color: LifestyleColors.kMiniBlack,
        ),
        child: UserImageCard(
            expand: false,
            onTap: () async {
              // await Navigator.push(
              //   context,
              //   PageRouteBuilder<void>(
              //     transitionDuration: const Duration(milliseconds: 500),
              //     reverseTransitionDuration: const Duration(milliseconds: 500),
              //     pageBuilder: (_, animation, __) => FadeTransition(
              //       opacity: animation,
              //       child: const UserDetailsScreen(),
              //     ),
              //   ),
              // );
              Get.to(
                () => const UserDetailsScreen(),
                duration: Duration(microseconds: 700),
                transition: Transition.fadeIn,
              );
            },
            user: user,
            profileFunctions: profileFunctions),
      ),
    );
  }

  buildSideIcons(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: Neumorphic(
        padding: EdgeInsets.symmetric(
          // horizontal: 2.w,
          vertical: 2.h,
        ),
        margin: EdgeInsets.only(right: 4.w, bottom: 7.h),
        style: const NeumorphicStyle(
          shape: NeumorphicShape.flat,
          shadowLightColor: Colors.black26,
          depth: -1,
          color: LifestyleColors.kTaupeBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  profileFunctions.updateProfile(
                    user: user,
                  );
                },
                icon: sideIcons(Icons.add_a_photo)),
            SizedBox(height: 2.h),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.toNamed(LifestyleRouteName.cartRoute);
                },
                icon: sideIcons(Icons.shopping_cart_checkout_sharp)),
            SizedBox(height: 2.h),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => EditBillingDetailsDialog(ref: ref));
                },
                icon: sideIcons(Icons.edit_document)),
            SizedBox(height: 2.h),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  profileFunctions.logOut();
                },
                icon: sideIcons(Icons.logout_outlined)),
          ],
        ),
      ),
    );
  }

  ShadowIcon sideIcons(IconData icon) {
    return ShadowIcon(
      icon: icon,
      color: LifestyleColors.kTaupeBackground,
      depth: 2,
      size: 25,
      shadowLightColor: LifestyleColors.black,
      // border: NeumorphicBorder(color: LifestyleColors.productBackground),
    );
  }

  Widget buildUserDetails() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 50.h,
          width: 70.w,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sp),
            ),
            child: profileFunctions.loadUserPicture(),
          ),
        ),
        Container(
          height: 20.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: LifestyleColors.kTaupeDarkened.withOpacity(0.6),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildUserDetailTexts(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildUserDetailTexts() {
    return [
      MediumText(
        font: LifestyleFonts.kComorantBold,
        text: user.name,
        color: Colors.white,
        size: 20.sp,
      ),
      SizedBox(height: 1.h),
      MediumText(
        font: LifestyleFonts.kComorantBold,
        text: user.email,
        color: Colors.white,
        size: 15.sp,
      ),
      SizedBox(height: 1.h),
      MediumText(
        font: LifestyleFonts.kComorantBold,
        text: user.address == '' ? 'Address not set' : user.address,
        color: Colors.white,
        size: 15.sp,
      ),
      SizedBox(height: 1.h),
      MediumText(
        font: LifestyleFonts.kComorantBold,
        text: user.phone == '' ? 'Phone number not set' : user.phone,
        color: Colors.white,
        size: 15.sp,
      ),
    ];
  }
}

class ShadowIcon extends StatelessWidget {
  const ShadowIcon({
    Key? key,
    this.color,
    this.depth,
    this.size = 20,
    required this.icon,
    this.border = const NeumorphicBorder.none(),
    this.shadowLightColor,
    this.intensity,
  }) : super(key: key);
  final Color? color;
  final double? depth;
  final double size;
  final IconData icon;
  final NeumorphicBorder border;
  final Color? shadowLightColor;
  final double? intensity;
  @override
  Widget build(BuildContext context) {
    return NeumorphicIcon(
      icon,
      size: size,
      style: NeumorphicStyle(
          intensity: intensity,
          depth: depth,
          color: color,
          border: border,
          shadowLightColor: shadowLightColor),
    );
  }
}

class UserImageCard extends StatelessWidget {
  const UserImageCard({
    Key? key,
    required this.user,
    required this.onTap,
    required this.expand,
    required this.profileFunctions,
  }) : super(key: key);
  final User user;
  final VoidCallback onTap;
  final bool expand;
  final ProfileFunctions profileFunctions;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: user.id,
        child: ParallaxImageCard(
            isAsset: profileFunctions.getuserPic() == '' ||
                    profileFunctions.getuserPic().isEmpty
                ? true
                : false,
            imageUrl: profileFunctions.loadUserPicture()),
      ),
    );
    // return
  }
}

// Neumorphic(
//  style = NeumorphicStyle(
//    boxShape: NeumorphicBoxShape.path(SharpEdgesPathProvider()),
//    // Other style properties...
//  ),
// //  child: // Your child widget here...
// )
