import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/Common/widgets/global_variables.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../state/providers/actions/provider_operations.dart';

class CategoriesImageTemplate extends ConsumerWidget {
  const CategoriesImageTemplate({
    Key? key,
    required this.color,
    this.text,
    required this.index,
    required this.image,
  }) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    x.Get.toNamed(LifestyleRouteName.categotyRoute, arguments: category);
  }

  final int index;
  final Color color;
  final String? text;
  final ImageProvider image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationFunction = ref.read(notificationFunctionProvider);
    return GestureDetector(
      onTap: (() {
        navigateToCategoryPage(context, GlobalVariables.categoryTitles[index]);
        // notificationFunction.uploadFcmToken();
      }),
      child: Container(
        padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF675E57),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          height: 150,
          width: 10,
          decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: image),
              color: color,
              borderRadius: BorderRadius.circular(5.sp)),
        ),
      ),
    );
  }
}
