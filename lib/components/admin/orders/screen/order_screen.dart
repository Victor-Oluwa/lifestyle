import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/orders/widgets/oder_body.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../state/providers/actions/provider_operations.dart';
import '../widgets/canceled_order_body.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderFunction = ref.read(orderFunctionsProvider);
    return Scaffold(
      backgroundColor: lightTaupe,
      appBar: AppBar(
        title: MediumText(
          font: comorant,
          text: 'All Orders'.toUpperCase(),
          size: 18.sp,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          TabBar(
            indicatorColor: LifestyleColors.kTaupeDarkened,
            dividerColor: Colors.transparent,
            indicator: DotIndicator(
              color: Colors.black,
              distanceFromCenter: 16,
              radius: 5,
              paintingStyle: PaintingStyle.stroke,
            ),
            controller: tabController,
            tabs: [
              MediumText(
                size: 17.sp,
                color: LifestyleColors.kTaupeDarkened,
                text: 'ALL ORDERS',
                font: LifestyleFonts.kCeraMedium,
              ),
              MediumText(
                size: 17.sp,
                color: LifestyleColors.kTaupeDarkened,
                text: 'CANCELLED',
                font: LifestyleFonts.kCeraMedium,
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: TabBarView(
                controller: tabController,
                children: [
                  OrderScreenBody(
                    ref: ref,
                    orderFunction: orderFunction,
                  ),
                  CanceledOrderBody(
                    ref: ref,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
