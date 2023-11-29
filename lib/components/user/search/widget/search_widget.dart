// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.pressed,
    required this.controller,
    required this.ref,
    this.submmit,
    this.horizontalPadding,
  }) : super(key: key);
  final VoidCallback? pressed;
  final TextEditingController controller;
  final WidgetRef ref;
  final double? horizontalPadding;
  final void Function(String)? submmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              color: LifestyleColors.kTaupeDark,
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(5.sp),
              elevation: 0,
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: submmit,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 1.w,
                    ),
                    child: IconButton(
                      onPressed: pressed,
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(top: 15.sp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                      borderSide: BorderSide.none),
                  hintStyle: const TextStyle(fontFamily: 'Comorant-Regular'),
                  hintText: 'Search products..',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
