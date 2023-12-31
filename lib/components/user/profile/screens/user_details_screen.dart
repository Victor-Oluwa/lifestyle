// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';

import '../../../../models-classes/user.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({
    Key? key,
    //  this.user = ref.read(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.read(userProvider);
    return UserDetailsItem(
      user: user,
      imageUrl: user.picture,
    );
  }
}

class UserDetailsItem extends ConsumerWidget {
  const UserDetailsItem({
    super.key,
    required this.imageUrl,
    required this.user,
  });

  final User user;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LifestyleColors.transparent,
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        tween: Tween(begin: 0, end: 1),
        builder: (_, value, __) => Stack(
          // fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: lerpDouble(0.90, 1.2, value),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 15.h, left: 13.w, right: 13.w, bottom: 24.h),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BackgroundUserCard(
                    user: user,
                    translation: value,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 0.h),
                child: SizedBox(
                  height: 50.h,
                  width: 70.w,
                  child: Hero(
                    tag: user.id,
                    child: ParallaxImageCard(
                      imageUrl: user.picture,
                      isAsset: false,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundUserCard extends StatelessWidget {
  const BackgroundUserCard({
    Key? key,
    required this.user,
    required this.translation,
  }) : super(key: key);

  final User user;
  final double translation;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0, 80 * translation, 0),
      child: Container(
        decoration: BoxDecoration(
          color: LifestyleColors.kTaupeDarkened.withOpacity(1),
          // border: Border.all(color: LifestyleColors.kTaupeDarkened),
          borderRadius: BorderRadius.all(Radius.circular(6.sp)),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.black54,
            //   blurRadius: 50,
            //   offset: Offset(1, 7),
            // ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _UserInfoRow(
                icon: SvgPicture.asset(
                  'assets/user.svg',
                  height: 4.0.h,
                  fit: BoxFit.cover,
                ),
                label: MediumText(
                  color: LifestyleColors.white,
                  font: LifestyleFonts.kPlayfair,
                  size: 13.sp,
                  text: 'Name',
                ),
                data: user.name.toUpperCase(),
              ),
              SizedBox(height: 1.h),
              _UserInfoRow(
                icon: SvgPicture.asset(
                  'assets/cell.svg',
                  height: 4.0.h,
                  fit: BoxFit.cover,
                ),
                label: MediumText(
                  color: LifestyleColors.white,
                  font: LifestyleFonts.kPlayfair,
                  size: 13.sp,
                  text: 'Phone',
                ),
                data: user.phone,
              ),
              SizedBox(height: 1.h),
              _UserInfoRow(
                icon: SvgPicture.asset(
                  'assets/mail.svg',
                  height: 4.0.h,
                  fit: BoxFit.cover,
                ),
                label: MediumText(
                  color: LifestyleColors.white,
                  font: LifestyleFonts.kPlayfair,
                  size: 13.sp,
                  text: 'Orders',
                ),
                data: '5',
              ),
              SizedBox(height: 2.h),
              Column(
                children: [
                  MediumText(
                    size: 18.sp,
                    color: LifestyleColors.white,
                    font: LifestyleFonts.kPlayfair,
                    text: 'ADDRESS',
                  )
                  // MediumText(
                  //   text: 'ADDRESS',

                  //   color: LifestyleColors.white,
                  // )
                ],
              ),
              MediumText(
                align: TextAlign.center,
                color: LifestyleColors.white,
                font: LifestyleFonts.kPlayfair,
                text: user.address,
                overflow: TextOverflow.visible,
                size: 14.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  const _UserInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    this.data,
  }) : super(key: key);

  final Widget icon;
  final Widget label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            icon,
            SizedBox(width: 2.w),
            label,
          ],
        ),
        MediumText(
          color: LifestyleColors.white,
          font: LifestyleFonts.kPlayfair,
          text: data ?? 'Not set',
        )
        // NeumorphicText(
        //   data ?? 'Info not set',
        //   style: const NeumorphicStyle(
        //       shadowLightColor: LifestyleColors.black,
        //       depth: 1,
        //       color: LifestyleColors.white),
        //   textStyle: NeumorphicTextStyle(
        //       fontFamily: LifestyleFonts.kPlayfair, fontSize: 16.sp),
        // )
      ],
    );
  }
}
