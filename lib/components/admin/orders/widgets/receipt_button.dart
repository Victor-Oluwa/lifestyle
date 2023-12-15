import 'package:flutter/Material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/strings/strings.dart';
import '../../../../Common/widgets/medium_text.dart';

class ReceiptButton extends StatelessWidget {
  const ReceiptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        animationDuration: const Duration(seconds: 1),
        color: LifestyleColors.kTaupeDark,
        shadowColor: LifestyleColors.shadowColor,
        elevation: 15,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.all(3.w),
          // height: 20.h,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                LifestyleStrings.whiteLogoImage,
                height: 7.h,
              ),
              const MediumText(
                  color: LifestyleColors.kTaupeBackground,
                  text: 'Purchase Reciept'),
            ],
          ),
        ),
      ),
    );
  }
}
