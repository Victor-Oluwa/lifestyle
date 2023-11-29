import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/snackbar_messages.dart';
import 'package:lifestyle/Common/widgets/utils.dart' as snack;
import 'package:lifestyle/common/widgets/utils.dart';
import 'package:lifestyle/components/user/cart/provider/cart_provider.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../models-classes/order.dart';
import '../../../../../../models-classes/user.dart';

class PaystackFunctions {
  final Ref ref;

  PaystackFunctions({required this.ref});

  final plugin = PaystackPlugin();
  Map<String, dynamic> initializePaymentResult = {};

  Charge charge = Charge();
  final String _publicKey = kPaystackPublicKey;

  startPaystark() async {
    await plugin.initialize(publicKey: _publicKey);
  }

  Future<void> buy({
    required int totalSum,
    required String email,
    required BuildContext context,
    VoidCallback? onSuccess,
  }) async {
    ref.read(cartIsProcessingProvider.notifier).state = true;
    final user = ref.read(userProvider);
    if (user.address.isEmpty || user.phone.isEmpty) {
      snack.showBottomSnackBar(
          message: 'Add your address and phone number before proceeding.',
          title: 'Empty Fields');
    }
    await startPaystark();
    return await placeOrder(
      user: user,
      totalSum: totalSum,
    ).then((order) async {
      if (order != Order.empty()) {
        await initialisePayment(
            orderId: order.id,
            amount: totalSum * 100,
            email: email,
            context: context,
            onSuccess: onSuccess);
      } else {
        ref.invalidate(cartIsProcessingProvider);
        log('Indicator invalidated (Order)');
      }
    });
  }

  Future<Order> placeOrder({
    required User user,
    required int totalSum,
  }) async {
    final cartServices = ref.read(cartServicesProvider);
    return await cartServices.placeOrder(
      address: user.address,
      totalSum: totalSum,
    );
  }

  Future<void> initialisePayment({
    required int amount,
    required String orderId,
    required String email,
    required BuildContext context,
    required VoidCallback? onSuccess,
  }) async {
    if (orderId != Order.empty().id) {
      await ref
          .read(paystackServicesProvider)
          .initializePayment(
            amount: amount,
            email: email,
          )
          .then((Map<String, dynamic> initResponse) {
        if (initResponse.isNotEmpty) {
          final accessCode = initResponse['data']['access_code'];
          final authorizationURL = initResponse['data']['authorization_url'];

          if (context.mounted) {
            checkOut(
                authorizationURL: authorizationURL,
                accessCode: accessCode,
                amount: amount,
                context: context,
                onSuccess: onSuccess,
                orderId: orderId);
          }
          ref.invalidate(cartIsProcessingProvider);
        } else {
          log('InitializePayment returned empty map');
          ref.invalidate(cartIsProcessingProvider);
        }
      });
    }
  }

// Checkout function
  Future<void> checkOut(
      {required String authorizationURL,
      required String accessCode,
      required int amount,
      required String orderId,
      required BuildContext context,
      VoidCallback? onSuccess}) async {
    final user = ref.read(userProvider);

    if (amount > 0 && user.email.isNotEmpty && accessCode.isNotEmpty) {
      charge.amount = amount;
      charge.email = user.email;
      charge.accessCode = accessCode;

      plugin
          .checkout(
        logo: Image.asset(
          'images/toplogo.png',
          height: 6.h,
          width: 6.h,
        ),
        context,
        charge: charge,
        fullscreen: false,
        method: CheckoutMethod.selectable,
      )
          .then((CheckoutResponse response) {
        if (response.status) {
          verifyPayment(
            response: response,
            user: user,
            amount: amount,
            orderId: orderId,
          );
        } else {
          ref.invalidate(cartIsProcessingProvider);
        }
      });
    } else {
      log('One or more check out parameter is empty: at [payStark_secret.dart]');
    }
  }

  Future<void> verifyPayment(
      {required CheckoutResponse response,
      required User user,
      required orderId,
      required int amount}) async {
    if (response.status) {
      final transactionReference = response.reference;

      ref
          .read(paystackServicesProvider)
          .verifyPaymentOnBackend(transactionReference: transactionReference!)
          .then((bool verified) async {
        if (verified == true) {
          await approveOrder(orderId: orderId);
          dropperMessage(
            'Order completed.',
            ' Go to your profile to track order status',
          );
        } else {
          dropperMessage(
            'ATTENTION',
            'Payment verification failed',
          );
        }
      });
    } else {
      dropperMessage(kCheckOutErrorMessage['Checkout Error'],
          kCheckOutErrorMessage['Checkout failed. Try again later'],
          duration: const Duration(seconds: 10));
    }
  }

  Future<void> approveOrder({required orderId}) async {
    final cartFunction = ref.read(cartFunctionProvider);
    await cartFunction.approveOrder(orderId: orderId);
  }
}
