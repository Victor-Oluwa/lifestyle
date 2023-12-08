import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/order-details/tracking/screen/order_tracking_screen.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/components/admin/order-details/function/order_details_function.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/components/admin/orders/widgets/general_order_details.dart';
import 'package:lifestyle/components/admin/orders/widgets/items_in_order.dart';
import 'package:lifestyle/components/admin/order-details/widgets/order_tracker.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/Material.dart';
import 'package:tuple/tuple.dart';
import '../../../../Common/strings/strings.dart';
import '../../../../core/error/widgets/error_message_widget.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/orders_provider.dart';
import 'package:get/get.dart';

import '../../orders/widgets/receipt_button.dart';
import '../../orders/widgets/receipt_view.dart';
import '../../orders/widgets/tracker_done_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as ps;
import 'package:printing/printing.dart';

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
    final OrderDetailsFunctions orderDetailsFunctions =
        ref.watch(orderDetailsFunctionProvider);
    final User user = ref.read(userProvider);
    final cartFunctions = ref.read(cartFunctionProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LifestyleColors.black,
        title: MediumText(
            font: LifestyleFonts.kCeraMedium,
            color: LifestyleColors.white,
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
                  SizedBox(
                    height: 1.h,
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
                        MediumText(text: 'User Name: ${order.customerName}'),
                        MediumText(text: 'Phone: ${user.phone}'),
                        MediumText(
                            overflow: TextOverflow.visible,
                            text: 'Address: ${order.address}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
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
                  ItemsInOrder(
                    order: order,
                    cartFunction: cartFunctions,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          () => OrderTrackingScreen(
                            order: order,
                          ),
                        );
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        color: LifestyleColors.black,
                        height: 7.h,
                        width: double.infinity,
                        child: const MediumText(
                            color: LifestyleColors.kTaupeDarkened,
                            text: 'Track Progress'),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  IconButton(
                    onPressed: () {
                      showGeneralDialog(
                          context: context,
                          transitionDuration: const Duration(milliseconds: 500),
                          barrierDismissible: true,
                          barrierLabel: '',
                          barrierColor: LifestyleColors.kTaupeDark,
                          transitionBuilder: (context, a1, a2, widget) {
                            return ReceiptViewWidget(
                              orderFunctions: orderDetailsFunctions,
                              a1: a1,
                              a2: a2,
                              widget: widget,
                              order: order,
                            );
                          },
                          pageBuilder: (context, animation1, animation2) {
                            return widget;
                          });
                    },
                    icon: const ReceiptButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
