import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/admin/admin-tab/admin_tab.dart';
import 'package:lifestyle/components/user/cart/widgets/detailsConfirmation/edit_details_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../home/widgets/cart_badge_widget.dart';
import '../function/profile_functions.dart';

class UserImageAndSideIconWidget extends ConsumerWidget {
  const UserImageAndSideIconWidget({
    Key? key,
    required this.profileFunctions,
    required this.user,
  }) : super(key: key);

  final ProfileFunctions profileFunctions;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 5.h,
      child: Center(
        child: Stack(
          children: [
            buildUserImageContainer(),
            buildLogoutButton(),
            buildProfilePictureButton(),
            buildEditButton(ref: ref, context: context),
            buildCartButton(ref),
            buildSwitchToAdminButton(user),
          ],
        ),
      ),
    );
  }

  Widget buildCartButton(WidgetRef ref) {
    return Positioned(
      right: 1.8.w,
      top: 2.h,
      child: GestureDetector(
          onTap: () => ref.read(homeFunctionProvider).navigateToCartScreen(),
          child: CartBadgeWidget(
            user: user,
            ref: ref,
            iconData: Icons.shopping_cart_checkout_sharp,
          )),
    );
  }

  buildSwitchToAdminButton(User user) {
    return user.type == 'admin'
        ? Positioned(
            right: 1.8.w,
            top: 25.h,
            child: InkWell(
              onTap: () {
                Get.offAll(() => const AdminTab());
              },
              child: const Icon(
                Icons.switch_account,
                color: LifestyleColors.kTaupeDarkened,
              ),
            ),
          )
        : const Text('');
  }

  Widget buildUserImageContainer() {
    return Container(
      padding: EdgeInsets.only(right: 10.w),
      decoration: const BoxDecoration(
        border:
            Border(right: BorderSide(color: LifestyleColors.kTaupeDarkened)),
        color: Colors.transparent,
      ),
      child: buildUserImage(),
    );
  }

  Widget buildUserImage() {
    return Container(
      width: 70.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.sp),
        ),
        color: Colors.blue,
        // image: profileFunctions.loadUserPicture(),
      ),
      child: buildUserDetails(),
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

  Widget buildLogoutButton() {
    return Positioned(
      right: 1.8.w,
      top: 20.h,
      child: InkWell(
        onTap: () {
          profileFunctions.logOut();
        },
        child: const Icon(
          Icons.logout,
          color: LifestyleColors.kTaupeDarkened,
        ),
      ),
    );
  }

  Widget buildEditButton(
      {required WidgetRef ref, required BuildContext context}) {
    return Positioned(
      right: 1.8.w,
      top: 14.h,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => EditBillingDetailsDialog(ref: ref));
        },
        child: const Icon(
          Icons.edit_document,
          color: LifestyleColors.kTaupeDarkened,
        ),
      ),
    );
  }

  Widget buildProfilePictureButton() {
    return Positioned(
      right: 2.w,
      top: 8.h,
      child: InkWell(
        onTap: () {
          profileFunctions.updateProfile(
            user: user,
          );
        },
        child: const Icon(
          Icons.add_a_photo,
          color: LifestyleColors.kTaupeDarkened,
        ),
      ),
    );
  }
}
