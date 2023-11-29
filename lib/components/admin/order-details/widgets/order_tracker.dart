import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/components/admin/order-details/function/order_details_function.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../state/providers/provider_model/user_provider.dart';

class OrderTrackerStepper extends StatelessWidget {
  const OrderTrackerStepper({
    super.key,
    required this.ref,
    required this.orderDetailsFunction,
    required this.order,
    required this.status,
  });

  final WidgetRef ref;
  final int status;
  final OrderDetailsFunction orderDetailsFunction;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (context, detailed) {
        if (ref.watch(userProvider).type == 'admin') {
          return TextButton(
            onPressed: () {
              log('Tapped');
              orderDetailsFunction.changeOrderStatus(
                context: context,
                order: order,
                status: status + 1,
              );
              log('Tappeddd');
            },
            child: Container(
              alignment: Alignment.center,
              width: 15.w,
              height: 3.h,
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(1.sp)),
              child: MediumText(
                text: 'Done',
                color: Colors.white,
                size: 15.sp,
              ),
            ),
          );
        }
        return const SizedBox();
      },
      currentStep: status <= 3 ? status : 3,
      // currentStep: ref.watch(currentStepProvider) <= 3
      //     ? ref.watch(currentStepProvider)
      //     : 3,

      steps: orderDetailsFunction.buildSteps(status: status
          // ref.watch(currentStepProvider),
          ),
    );
  }
}

 // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<Order>('order', order));
  //   properties.add(DiagnosticsProperty<Order>('order', order));
  //   properties.add(DiagnosticsProperty<Order>('order', order));
  //   properties.add(DiagnosticsProperty<Order>('order', order));
  //   properties.add(DiagnosticsProperty<Order>('order', order));
  // }