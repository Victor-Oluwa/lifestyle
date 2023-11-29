import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProductModelField extends StatelessWidget {
  const AddProductModelField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.white,
      borderType: BorderType.RRect,
      dashPattern: const [10, 4],
      radius: Radius.circular(15.sp),
      strokeCap: StrokeCap.round,
      child: Container(
        width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_chart,
              size: 27.sp,
            ),
            SizedBox(
              height: 3.h,
            ),
            const MediumText(
              text: 'Select 3D Model',
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
