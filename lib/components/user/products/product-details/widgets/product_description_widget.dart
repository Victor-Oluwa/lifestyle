import 'package:flutter/Material.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    super.key,
    required this.product,
    required this.showFullText,
  });

  final Product product;
  final bool showFullText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20.h,
        margin: EdgeInsets.only(left: 3.5.w, right: 3.w, bottom: 1.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 17.sp, fontFamily: comorant, color: Colors.white),
                product.description,
                maxLines: showFullText ? null : 9,
                overflow: showFullText ? null : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
