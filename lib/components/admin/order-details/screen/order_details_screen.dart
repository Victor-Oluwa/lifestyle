import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/components/admin/order-details/function/order_details_function.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/components/admin/orders/widgets/general_order_details.dart';
import 'package:lifestyle/components/admin/orders/widgets/order_item_detail.dart';
import 'package:lifestyle/components/admin/order-details/widgets/order_tracker.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/Material.dart';
import 'package:tuple/tuple.dart';
import '../../../../core/error/widgets/error_message_widget.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/orders_provider.dart';
import 'package:get/get.dart';

import '../../orders/widgets/tracker_done_button.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({
    super.key,
  });
  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  final Order order = Get.arguments;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrderDetailsFunction orderDetailsFunction =
        ref.watch(orderDetailsFunctionProvider);
    final User user = ref.read(userProvider);
    final cartFunctions = ref.read(cartFunctionProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.3),
        title: MediumText(
            font: LifestyleFonts.kCeraMedium,
            color: LifestyleColors.kTaupeDarkened,
            size: 22,
            text:
                ref.watch(orderProvider).status < 3 ? 'Pending' : 'Completed'),
      ),
      backgroundColor: const Color(0xFFB0A291),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  MediumText(
                    font: LifestyleFonts.kCeraMedium,
                    text: 'Order Details',
                    color: LifestyleColors.kTaupeDarkened,
                    size: 16.sp,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GeneralOrderDetail(
                    order: order,
                    cartFunctions: cartFunctions,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MediumText(
                    font: LifestyleFonts.kCeraMedium,
                    text: 'Billing Details',
                    color: LifestyleColors.kTaupeDarkened,
                    size: 16.sp,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(1.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: LifestyleColors.kTaupeDarkened,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MediumText(text: 'Buyer Name: ${order.customerName}'),
                        MediumText(text: 'Phone: ${user.phone}'),
                        MediumText(
                            overflow: TextOverflow.visible,
                            text: 'Address: ${order.address}'),
                      ],
                    ),
                  ),
                  MediumText(
                    font: LifestyleFonts.kCeraMedium,
                    size: 17.sp,
                    text: 'Purchase Details',
                    color: LifestyleColors.kTaupeDarkened,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  OrderItemDetails(
                    order: order,
                    cartFunction: cartFunctions,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MediumText(
                    font: LifestyleFonts.kCeraMedium,
                    text: 'Tracking',
                    size: 16.sp,
                    color: LifestyleColors.kTaupeDarkened,
                  ),
                  ref
                      .watch(getOrderStatusProvider(
                    Tuple2<BuildContext, Order>(context, order),
                  ))
                      .when(
                    data: (data) {
                      log('Product current step: $data');
                      log('Refreshed:');

                      return OrderTrackerStepper(
                          status: data,
                          order: order,
                          ref: ref,
                          orderDetailsFunction: orderDetailsFunction);
                    },
                    error: (e, st) {
                      return const ErrorMessageWidget(
                        errorMessage: 'Could not load tracker. Try again later',
                      );
                    },
                    loading: () {
                      return const CircularProgressIndicator();
                    },
                  ),
                  ref.watch(userProvider).type == 'admin'
                      ? GestureDetector(
                          onTap: () {
                            orderDetailsFunction.changeOrderStatus(
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
            ),
          ),
        ),
      ),
    );
  }
}
