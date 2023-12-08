// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/Common/widgets/processing_indicator.dart';
import 'package:lifestyle/components/admin/order-details/tracking/function/order_tracking_function.dart';
import 'package:lifestyle/components/admin/order-details/tracking/provider/order_tracking_provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../core/error/widgets/error_message_widget.dart';
import '../../../../../models-classes/order.dart';
import '../../../../../state/providers/actions/provider_operations.dart';
import '../../../../../state/providers/provider_model/user_provider.dart';
import '../../../orders/widgets/tracker_done_button.dart';
import '../../widgets/order_tracker.dart';

class OrderTrackingScreen extends ConsumerWidget {
  const OrderTrackingScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OrderTrackingFunction orderDetailsFunctions =
        ref.watch(orderTrackingFunctionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const MediumText(
          text: 'Order Tracker',
          color: Colors.white,
        ),
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: ref
                  .watch(getOrderStatusProvider(
                Tuple2<BuildContext, Order>(context, order),
              ))
                  .when(
                data: (data) {
                  return OrderTrackerStepper(
                      status: data,
                      order: order,
                      ref: ref,
                      orderTrackingFunction: orderDetailsFunctions);
                },
                error: (e, st) {
                  return const Center(
                    child: ErrorMessageWidget(
                      errorMessage: 'Could not load tracker. Try again later',
                    ),
                  );
                },
                loading: () {
                  return const Center(child: ProcessingIndicator());
                },
              ),
            ),
          ),
          ref.watch(userProvider).type == 'admin'
              ? GestureDetector(
                  onTap: () {
                    orderDetailsFunctions.changeOrderStatus(
                      context: context,
                      order: order,
                      status: 0,
                    );
                  },
                  child: const TrackerResetButton(),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
