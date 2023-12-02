// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/core/bouncer/provider/bouncer_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:lifestyle/models-classes/product.dart';

import '../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../common/widgets/medium_text.dart';
import '../../../../state/providers/actions/provider_operations.dart';

class QuantityPicker extends ConsumerWidget {
  const QuantityPicker({
    Key? key,
    required this.product,
    required this.cartFunctions,
    required this.maxValue,
    required this.ref,
  }) : super(key: key);
  final Product product;
  final CartFunctions cartFunctions;
  final int maxValue;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentValue = 0;

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                ref.invalidate(isProcessingProvider);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (currentValue > 1) {
                      setState(() {
                        final newValue = currentValue - 1;
                        currentValue = newValue.clamp(0, 100);
                      });
                    }
                  }),
              MediumText(
                text: maxValue > 0 ? 'SELECT QUANTITY' : 'OUT OF STOCK',
                font: LifestyleFonts.kComorantBold,
                color: LifestyleColors.white,
              ),
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (currentValue < maxValue) {
                      setState(() {
                        final newValue = currentValue + 1;
                        currentValue = newValue.clamp(0, 100);
                      });
                    }
                  }),
            ],
          ),
          NumberPicker(
              infiniteLoop: true,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
              ),
              axis: Axis.horizontal,
              minValue: 0,
              maxValue: maxValue,
              value: currentValue,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              }),
          Container(
            margin: EdgeInsets.only(top: 1.h),
            child: IconButton(
                icon: const MediumText(
                  text: 'DONE',
                  font: LifestyleFonts.kComorantBold,
                  color: LifestyleColors.white,
                ),
                onPressed: () async {
                  final bouncer = ref.read(bouncerProvider);
                  bouncer.run(() async {
                    await cartFunctions.updateCartItemQuantity(
                        productId: product.id, quantity: currentValue);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  });
                }),
          ),
        ],
      );
    });
  }
}
