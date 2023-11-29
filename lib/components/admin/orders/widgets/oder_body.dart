// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/orders/functions/order_functions.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class OrderScreenBody extends StatelessWidget {
  const OrderScreenBody({
    Key? key,
    required this.ref,
    required this.orderFunction,
  }) : super(key: key);
  final WidgetRef ref;
  final OrderFunctions orderFunction;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return ref.watch(getOrdersFutureProvider).when(data: (List<Order> order) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: order.length,
              itemBuilder: (context, index) {
                String status() {
                  if (order[index].status == 0) {
                    return 'Status: Queue';
                  } else if (order[index].status == 1) {
                    return 'Status: Processing';
                  } else if (order[index].status == 2) {
                    return 'Status: Recieved';
                  } else {
                    return 'Status: Completed';
                  }
                }

                return GestureDetector(
                  onTap: () {
                    orderFunction.navigateToOrderDetailScren(order[index]);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.h,
                        margin: EdgeInsets.only(left: 4.w, bottom: 2.h),
                        decoration: BoxDecoration(
                          color: taupe,
                          borderRadius: BorderRadius.circular(
                            5.sp,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                // orderss![index].products[index].images[0],
                                order[index].products[0].images[0]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MediumText(
                                color: LifestyleColors.kTaupeDarkened,
                                size: 15.sp,
                                text: user.type == 'admin'
                                    ? 'Customer Name: ${order[index].customerName}'
                                    : 'Name: ${order[index].customerName}',
                              ),
                              MediumText(
                                color: LifestyleColors.kTaupeDarkened,
                                size: 15.sp,
                                text: 'Id: ${order[index].id}',
                              ),
                              MediumText(
                                color: LifestyleColors.kTaupeDarkened,
                                size: 15.sp,
                                text: 'Address: ${order[index].address}'.trim(),
                              ),
                              MediumText(
                                color: LifestyleColors.kTaupeDarkened,
                                size: 15.sp,
                                text: 'Date: ${order[index].orderTime}',
                              ),
                              MediumText(
                                color: LifestyleColors.kTaupeDarkened,
                                size: 15.sp,
                                text: status(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          //  TabBar(tabs: [])
        ],
      );
    }, error: (p, st) {
      p.printError();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Image(
                height: 15.h,
                width: 15.h,
                image: const AssetImage(
                  'images/toplogo.png',
                ),
              ),
            ),
          )
        ],
      );
    }, loading: () {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Image(
                height: 15.h,
                width: 15.h,
                image: const AssetImage(
                  'images/toplogo.png',
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
