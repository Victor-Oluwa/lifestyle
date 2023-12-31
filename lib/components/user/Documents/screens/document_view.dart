// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';

import '../../../../Common/strings/strings.dart';
import '../../../../Common/widgets/app_constants.dart';
import '../../../../models-classes/documents.dart';
import '../../../../routes-management/lifestyle_routes_names.dart';
import '../widgets/dropdown_widget.dart';

class DocumentsView extends StatefulWidget {
  const DocumentsView({super.key});

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView>
    with TickerProviderStateMixin {
  late PageController _docPageController;

  @override
  void initState() {
    _docPageController = PageController(viewportFraction: 0.8);

    _docPageController.addListener(() {
      pageListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _docPageController
      ..removeListener(pageListener)
      ..dispose();

    super.dispose();
  }

  ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  void pageListener() {
    pageNotifier.value = _docPageController.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Neumorphic(
            padding: EdgeInsets.all(15.sp),
            style: const NeumorphicStyle(
              depth: -1,
              color: LifestyleColors.kTaupeBackground,
              shape: NeumorphicShape.convex,
            ),
            child: NeumorphicText(
              'DOUCMENTS',
              textStyle: NeumorphicTextStyle(fontSize: 20.sp),
              style: const NeumorphicStyle(
                intensity: 20,
                depth: 1,
                color: LifestyleColors.kTaupeBackground,
              ),
            )),
        // title: MediumText(
        //   font: comorant,
        //   size: 18.sp,
        //   text: 'DOCUMENTS',
        //   color: Colors.white,
        // ),
        actions: const [
          DocumentsPageDropdown(),
        ],
      ),
      backgroundColor: const Color(0xFFB0A291),
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: 65.h,
              child: ValueListenableBuilder(
                  valueListenable: pageNotifier,
                  builder: (__, page, ___) {
                    return PageView.builder(
                      controller: _docPageController,
                      clipBehavior: Clip.none,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final document = LifestyleDocument.values[index];
                        final percent = page - index;
                        return DocumentCard(
                            percent: percent, documentUrl: document.imageUrl);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    Key? key,
    required this.documentUrl,
    required this.percent,
  }) : super(key: key);
  final String documentUrl;
  final double percent;

  @override
  Widget build(BuildContext context) {
    navigateToBrowser(url) {
      Get.toNamed(LifestyleRouteName.browserRoute, arguments: url);
    }

    return AnimatedContainer(
        width: 90.w,
        duration: kThemeAnimationDuration,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: ParallaxImageCard(
          parallaxValue: percent,
          imageUrl: documentUrl,
        ));
  }
}
