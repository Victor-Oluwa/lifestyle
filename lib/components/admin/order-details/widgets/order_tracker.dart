import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/order-details/tracking/function/order_tracking_function.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../state/providers/provider_model/user_provider.dart';

class OrderTrackerStepper extends StatelessWidget {
  const OrderTrackerStepper({
    super.key,
    required this.ref,
    required this.orderTrackingFunction,
    required this.order,
    required this.status,
  });

  final WidgetRef ref;
  final int status;
  final OrderTrackingFunction orderTrackingFunction;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      elevation: 20,
      connectorColor: const MaterialStatePropertyAll(Colors.black),
      controlsBuilder: (context, detailed) {
        if (ref.watch(userProvider).type == 'admin') {
          return TextButton(
            onPressed: () {
              orderTrackingFunction.changeOrderStatus(
                context: context,
                order: order,
                status: status + 1,
              );
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
      steps: orderTrackingFunction.buildSteps(status: status),
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