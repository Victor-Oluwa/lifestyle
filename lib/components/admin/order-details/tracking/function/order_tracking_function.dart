// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Common/widgets/app_constants.dart';
import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/order.dart';
import '../../../../../state/providers/actions/provider_operations.dart';

class OrderTrackingFunction {
  final Ref ref;
  OrderTrackingFunction({
    required this.ref,
  });

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
    return [
      Step(
        label: const Icon(
          Icons.check_box,
        ),
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
}
