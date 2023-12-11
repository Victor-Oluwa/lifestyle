import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/app_constants.dart';
import '../../../../routes-management/lifestyle_routes_names.dart';
import '../widgets/dropdown_widget.dart';

class DocumentsView extends StatefulWidget {
  const DocumentsView({super.key});

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  final String _brochureUrl = kBrochureUrl;
  final String _profileDocUrl = kProfileDocUrl;

  navigateToBrowser(url) {
    Get.toNamed(LifestyleRouteName.browserRoute, arguments: url);
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.8);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: MediumText(
          font: comorant,
          size: 18.sp,
          text: 'DOCUMENTS',
          color: Colors.white,
        ),
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
              child: PageView(
                controller: controller,
                children: [
                  InkWell(
                    onTap: () {
                      navigateToBrowser(_brochureUrl);
                    },
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(right: 3.w, top: 1.h, bottom: 1.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            // fit: BoxFit.cover,
                            image: AssetImage('images/brochure.jpg')),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToBrowser(_profileDocUrl);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(right: 3.w, top: 1.h, bottom: 1.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            // fit: BoxFit.cover,
                            image: AssetImage('images/bProfile.jpg')),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
