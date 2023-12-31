// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../../../Common/widgets/medium_text.dart';
// import '../../../../Common/widgets/utils.dart';

// class ArBlankPage extends StatelessWidget {
//   const ArBlankPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const MediumText(
//           text: 'COMING SOON',
//           color: LifestyleColors.kTaupeBackground,
//         ),
//       ),
//       backgroundColor: LifestyleColors.kTaupeBackground,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             color: LifestyleColors.kTaupeBackground,
//             child: Image.asset(
//               height: 30.h,
//               width: 30.h,
//               'images/ARw.png',
//             ),
//           ),
//           SizedBox(
//             height: 4.h,
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
//             width: 78.w,
//             decoration: BoxDecoration(border: Border.all(color: Colors.white)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MediumText(
//                   text: 'AR MODE',
//                   size: 20.sp,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 3.w, right: 3.w),
//                   child: MediumText(
//                       align: TextAlign.center,
//                       size: 14.sp,
//                       maxLine: 4,
//                       text:
//                           'Utilizing augmented reality (AR) technology, this feature allows you to seamlessly position furniture pieces in your real-world environment, offering a preview of how they would appear in your space before making a purchase. '),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     dropperMessage('COMING SOON',
//                         "Oops! You've stumbled into the future! This feature is currently under construction by our team of tech wizards. Stay tuned for the magic to unfold!",
//                         duration: const Duration(seconds: 10));
//                     // Get.toNamed(LifestyleRouteName.arRoute);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     // height: 3.h,
//                     width: 35.w,
//                     decoration: const BoxDecoration(
//                         color: LifestyleColors.kTaupeDarkened),
//                     child: const MediumText(
//                       text: 'PROCEED',
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/Material.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/product_view_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/models-classes/category.dart';

import 'remote_details.dart';

class ArBlankPage extends StatefulWidget {
  const ArBlankPage({super.key});

  @override
  State<ArBlankPage> createState() => _ArBlankPageState();
}

class _ArBlankPageState extends State<ArBlankPage> {
  late PageController controller;
  final ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  @override
  void initState() {
    controller = PageController(viewportFraction: 0.8);
    controller.addListener(pageListener);
    super.initState();
  }

  void pageListener() {
    pageNotifier.value = controller.page ?? 0;
  }

  double _getOffsetX(double percent) => percent.isNegative ? 30.0 : -30.0;

  Matrix4 _getOutTranslate(double percent, int selected, int index) {
    final x = selected != index && selected != -1 ? _getOffsetX(percent) : 0.0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 80.h,
              width: double.infinity,
              child: ValueListenableBuilder<double>(
                  valueListenable: pageNotifier,
                  builder: (_, page, __) {
                    return ValueListenableBuilder(
                        valueListenable: roomSelectorNotifier,
                        builder: (_, selected, __) {
                          return PageView.builder(
                              controller: controller,
                              itemCount: ProductCategory.values.length,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                final category = ProductCategory.values[index];
                                final percent = page - index;
                                final isSelected = selected == index;

                                return AnimatedContainer(
                                  transform: _getOutTranslate(
                                      percent, selected, index),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  curve: Curves.fastOutSlowIn,
                                  height: 60.h,
                                  duration: kThemeAnimationDuration,
                                  child: RoomCard(
                                    category: category,
                                    expand: true,
                                    percent: percent,
                                    onTap: () async {
                                      // if (isSelected) {
                                      await Navigator.push(
                                        context,
                                        PageRouteBuilder<void>(
                                          transitionDuration:
                                              const Duration(milliseconds: 800),
                                          reverseTransitionDuration:
                                              const Duration(milliseconds: 800),
                                          pageBuilder: (_, animation, __) =>
                                              FadeTransition(
                                            opacity: animation,
                                            child: RoomDetailScreen(
                                                category: category),
                                          ),
                                        ),
                                      );
                                      roomSelectorNotifier.value = -1;
                                      // }
                                    },
                                  ),
                                );
                              });
                        });
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key? key,
    required this.percent,
    required this.category,
    required this.onTap,
    required this.expand,
  }) : super(key: key);

  final double percent;
  final ProductCategory category;
  final VoidCallback onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: expand ? 1 : 0),
        duration: const Duration(milliseconds: 200),
        builder: (_, value, __) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: Transform(
                  transform: Matrix4.translationValues(0, -90 * value, 0),
                  child: GestureDetector(
                    onTap: onTap,
                    child: Hero(
                      tag: category.id,
                      flightShuttleBuilder: (_, animation, __, ___, ____) {
                        return DefaultTextStyle(
                          style: TextStyle(color: Colors.white),
                          child: AnimatedBuilder(
                            animation: animation,
                            builder: (context, _) => RoomDetailItems(
                              animation: animation,
                              topPadding: 0.0,
                              room: category,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          ParallaxImageCard(
                            imageUrl: category.imageUrl,
                          ),
                          VerticalCategoryName(category: category)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
