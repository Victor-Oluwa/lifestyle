// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/add_product/function/add_product_functions.dart';
import 'package:lifestyle/components/admin/add_product/provider/add_product_provider.dart';

class AddProductImageField extends StatelessWidget {
  const AddProductImageField({
    Key? key,
    required this.addProductFunction,
    required this.ref,
  }) : super(key: key);
  final AddProductFunctions addProductFunction;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(addProductImageProvider);
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
          child: buildProductImageFieldImage(images)),
    );
  }

/*Assign the picked image to
the buildProductImageField if the
product image provider is not empty*/
  Widget buildProductImageFieldImage(List<File> images) {
    return images.isNotEmpty
        ? Image.file(
            images[0],
            height: 15.h,
            width: 9.w,
          )
        : emptyImageField();
  }

  Column emptyImageField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.folder_open,
          size: 27.sp,
        ),
        SizedBox(height: 3.h),
        const MediumText(
          text: 'Select product image',
          color: Colors.white,
        )
      ],
    );
  }
}
