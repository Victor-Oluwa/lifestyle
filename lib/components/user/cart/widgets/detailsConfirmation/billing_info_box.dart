// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/user.dart';
import 'edit_details_dialog.dart';

class BillingInfoBox extends StatelessWidget {
  const BillingInfoBox({
    Key? key,
    required this.user,
    required this.ref,
  }) : super(key: key);

  final User user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      alignment: Alignment.topLeft,
      width: 85.w,
      decoration: const BoxDecoration(color: LifestyleColors.kTaupeDark),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MediumText(
                  color: Colors.white,
                  text: 'Billing Info',
                  size: 17.sp,
                  font: LifestyleFonts.kComorantBold,
                ),
                TextButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => EditBillingDetailsDialog(
                                ref: ref,
                              ));
                    },
                    child: const MediumText(
                      color: Colors.white,
                      text: 'Edit',
                      font: LifestyleFonts.kComorantBold,
                    ))
              ],
            ),
            Row(
              children: [
                MediumText(
                  color: Colors.white,
                  size: 15.sp,
                  text: 'Name: ',
                  font: LifestyleFonts.kComorantBold,
                ),
                Expanded(
                  child: MediumText(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    size: 15.sp,
                    text: user.name,
                    font: LifestyleFonts.kComorantBold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MediumText(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  text: 'Email: ',
                  font: LifestyleFonts.kComorantBold,
                  size: 15.sp,
                ),
                Expanded(
                  child: MediumText(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    text: user.email,
                    size: 15.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MediumText(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  text: 'Mobile: ',
                  size: 15.sp,
                  font: LifestyleFonts.kComorantBold,
                ),
                Expanded(
                  child: MediumText(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    text: user.phone.isEmpty ? 'Not set' : user.phone.trim(),
                    size: 15.sp,
                    font: LifestyleFonts.kComorantBold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MediumText(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  text: 'Address: ',
                  size: 15.sp,
                  font: LifestyleFonts.kComorantBold,
                ),
                Expanded(
                  child: MediumText(
                    color: Colors.white,

                    // overflow: TextOverflow.ellipsis,
                    text:
                        user.address.isEmpty ? 'Not set' : user.address.trim(),
                    size: 15.sp,
                    font: LifestyleFonts.kComorantBold,
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
