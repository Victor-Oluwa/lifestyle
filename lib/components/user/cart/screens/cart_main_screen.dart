import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/widgets/processing_indicator.dart';

class CartViewScreen extends ConsumerStatefulWidget {
  const CartViewScreen({super.key});

  @override
  ConsumerState<CartViewScreen> createState() => _CartViewScreen();
}

class _CartViewScreen extends ConsumerState<CartViewScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    final paystackFunction = ref.read(paystackFunctionsProvider);
    paystackFunction.startPaystark();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final cartFunction = ref.read(cartFunctionProvider);
    cartFunction.syncUserCart();
    super.didChangeDependencies();
    ref.invalidate(isProcessingProvider);
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartFunction = ref.watch(cartFunctionProvider);
    final cart = cartFunction.getUserCartList();
    final isProcessing = ref.watch(isProcessingProvider);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: MediumText(
              font: comorant,
              text: 'My Cart',
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          backgroundColor: LifestyleColors.kTaupeBackground,
          body: Stack(
            children: [
              cartFunction.buildCartView(
                  cart: cart, cartFunction: cartFunction, ref: ref),
              isProcessing ? const ProcessingIndicator() : const Text('')
            ],
          )),
    );
  }
}
