import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/order.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class CanceledOrderBody extends StatelessWidget {
  const CanceledOrderBody({
    Key? key,
    required this.ref,
  }) : super(key: key);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return ref.watch(getFailedOrdersFutureProvider).when(
        data: (List<Order> data) {
      final order = data.reversed.toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: order.length,
              primary: true,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      // alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.h,
                          margin: EdgeInsets.only(left: 4.w, bottom: 2.h),
                          decoration: BoxDecoration(
                            color: LifestyleColors.kTaupeDarkened,
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
                        Positioned(
                          top: 1.h,
                          left: 19,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: const BoxDecoration(
                                color: LifestyleColors.transparent),
                            child: const MediumText(
                              text: 'Canceled',
                              color: LifestyleColors.kTaupeBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
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
                              overflow: TextOverflow.ellipsis,
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
                              text: 'Paid: ${order[index].paid}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          //  TabBar(tabs: [])
        ],
      );
    }, error: (_, st) {
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
