import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import '../../../../Common/widgets/app_constants.dart';
import '../../../../Common/widgets/medium_text.dart';

class OrderDetailsFunction {
  final Ref ref;
  OrderDetailsFunction({required this.ref});
  int fetchedOrderStatus = 0;
  int currentStep = 0;
  int fetchedStatus = 0;

  User getUser({required BuildContext context}) {
    return ref.read(userProvider);
    // Provider.of<UserProvider>(context).user;
  }

  fetchOrderStatus(
      {required Order order,
      required BuildContext context,
      required VoidCallback state}) async {
    final orderDetailsServices = ref.read(orderDetailsProvider);
    fetchedOrderStatus =
        await orderDetailsServices.fetchOrderStatus(order: order);
    state.call();
  }

  Future<void> getOrderStatus({
    required Order order,
    required BuildContext context,
  }) async {
    final orderDetailsServices = ref.read(orderDetailsProvider);
    await orderDetailsServices.fetchOrderStatus(order: order);
    // ref.read(orderStatusStateProvider.notifier).state = orderStatus;
  }

  Future<void> changeOrderStatus({
    required BuildContext context,
    required Order order,
    required int status,
  }) async {
    await ref
        .read(orderDetailsProvider)
        .changeOrderStatus(
          context: context,
          status: status,
          order: order,
        )
        .then((value) {
      log('Invalidate called');
      ref.invalidate(getOrderStatusProvider);
    });

    // ref.read(orderStatusStateProvider.notifier).state = orderStatus;
  }

  List<Step> buildSteps({required int status}) {
    // final orderStatusStProvider = order.status;
    return [
      Step(
        label: const Icon(Icons.check_box),
        title: MediumText(text: 'Queue', font: comorant),
        content: MediumText(text: 'Order has been placed', font: comorant),
        isActive: status >= 0,
        state: status >= 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: MediumText(text: 'In Progress', font: comorant),
        content: MediumText(text: 'Order is beign processed', font: comorant),
        isActive: status >= 1,
        state: status >= 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: MediumText(text: 'Received', font: comorant),
        content:
            MediumText(text: 'You have received your order', font: comorant),
        isActive: status >= 2,
        state: status >= 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        label: const Icon(Icons.check_box),
        title: MediumText(text: 'Completed', font: comorant),
        content: MediumText(text: 'Order Completed', font: comorant),
        isActive: status >= 3,
        state: status >= 3 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  // get buildStep => _buildSteps;
}
