// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/Common/widgets/processing_indicator.dart';
import 'package:lifestyle/components/user/cart/provider/cart_provider.dart';
import 'package:lifestyle/core/bouncer/provider/bouncer_provider.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';

import '../../../../state/providers/provider_model/user_provider.dart';
import '../../../../state/providers/reference/provider_refer.dart';
import '../widgets/detailsConfirmation/billing_info_box.dart';
import '../widgets/detailsConfirmation/order_cost_box.dart';
import '../widgets/detailsConfirmation/order_date_box.dart';
import '../widgets/detailsConfirmation/order_products_box.dart';
import '../widgets/detailsConfirmation/proceed_button.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CartDetailsConfirmation extends ConsumerStatefulWidget {
  const CartDetailsConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CartDetailsConfirmation> createState() =>
      _CartDetailsConfirmationState();
}

class _CartDetailsConfirmationState
    extends ConsumerState<CartDetailsConfirmation> {
  @override
  void didChangeDependencies() {
    ref.invalidate(cartIsProcessingProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final paystackFunction = ref.watch(paystackFunctionsProvider);
    final user = ref.watch(userProvider);
    final bool isProcessing = ref.watch(cartIsProcessingProvider);

    paystackFunction.startPaystark();
    final cartFunction = ProviderReference.cartFunction(ref: ref);
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LifestyleColors.kTaupeBackground,
      appBar: AppBar(
        backgroundColor: LifestyleColors.black,
        centerTitle: true,
        title: MediumText(
          color: Colors.white,
          size: 20.sp,
          text: 'Order Details',
          font: LifestyleFonts.kComorantBold,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      // decoration: const BoxDecoration(color: Colors.black26),
                      // padding: EdgeInsets.only(top: 4.h),
                      margin: EdgeInsets.only(top: 4.5.h),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OrderDateBox(
                                    formattedDate: formattedDate, user: user),
                                SizedBox(height: 2.h),
                                OrderCostBox(cartFunction: cartFunction),
                                SizedBox(height: 2.h),
                                BillingInfoBox(
                                  user: user,
                                  ref: ref,
                                ),
                                SizedBox(height: 2.h),
                                OrderProductsBox(
                                  user: user,
                                  cartFunctions: cartFunction,
                                ),
                                SizedBox(height: 1.5.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  OrderDetailsProceedButton(
                    onTap: () async {
                      final paystackFunctions =
                          ref.read(paystackFunctionsProvider);
                      final bouncer = ref.read(bouncerProvider);
                      bouncer.run(delay: const Duration(seconds: 1), () {
                        paystackFunctions.buy(
                            totalSum: int.parse(cartFunction.getSum()),
                            email: user.email,
                            context: context);
                      });
                    },
                    text: 'proceed',
                  ),
                ],
              ),
            ),
          ),
          isProcessing ? const ProcessingIndicator() : const Text(''),
        ],
      ),
    );
  }
}
