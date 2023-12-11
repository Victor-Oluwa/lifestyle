// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/Material.dart';
import 'package:lifestyle/components/admin/order-details/function/order_details_function.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/components/admin/orders/functions/order_functions.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/strings/strings.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/order.dart';

class ReceiptViewWidget extends StatelessWidget {
  const ReceiptViewWidget({
    Key? key,
    required this.order,
    required this.a1,
    required this.a2,
    required this.widget,
    required this.orderFunctions,
  }) : super(key: key);

  final Order order;
  final Animation<double> a1;
  final Animation<double> a2;
  final Widget widget;
  final OrderDetailsFunctions orderFunctions;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: a1.value,
      child: Opacity(
        opacity: a1.value,
        child: Container(
          color: LifestyleColors.kTaupeDark,
          padding: EdgeInsets.all(3.w),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          // height: 50.h,
          // width: 80.w,
          child: SingleChildScrollView(
            child: Material(
              color: LifestyleColors.kTaupeDark,
              child: Column(
                children: [
                  Image.asset(
                    LifestyleAssetImages.whiteLogoImage,
                    height: 7.h,
                  ),
                  const MediumText(
                      color: LifestyleColors.white, text: 'Purchase Reciept'),
                  SizedBox(
                    height: 2.h,
                  ),
                  DottedBorder(
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MediumText(
                                  color: LifestyleColors.white, text: 'Date: '),
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: '${order.orderTime}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Customer name: '),
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: order.customerName)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Order ID: '),
                              MediumText(
                                  color: LifestyleColors.white, text: order.id)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Status: '),
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: order.status == 0
                                      ? 'Queu'
                                      : order.status == 1
                                          ? 'In Progress'
                                          : order.status == 2
                                              ? 'Recieved'
                                              : order.status == 3
                                                  ? 'Completed'
                                                  : 'Nill')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  DottedBorder(
                    child: Column(
                      children: order.products.map((product) {
                        final index = order.products.indexOf(product);
                        return ListTile(
                          title: MediumText(
                              color: LifestyleColors.white, text: product.name),
                          subtitle: MediumText(
                              color: LifestyleColors.white,
                              text: product.price.toString()),
                          trailing: MediumText(
                              color: LifestyleColors.white,
                              text: order.quantity[index].toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  DottedBorder(
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Shipping fee: '),
                              MediumText(
                                  color: LifestyleColors.white, text: '0.0')
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MediumText(
                                  color: LifestyleColors.white, text: 'VAT: '),
                              MediumText(
                                  color: LifestyleColors.white, text: '0.0')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Total: '),
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: order.totalPrice.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  IconButton(
                      onPressed: () async {
                        orderFunctions.printReceipt(order);
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 6.h,
                        decoration:
                            const BoxDecoration(color: LifestyleColors.black),
                        child: const MediumText(text: 'SAVE'),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
