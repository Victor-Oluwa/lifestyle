import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';

import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as ps;
import 'package:pdf/pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/strings/strings.dart';

class OrderDetailsFunctions {
  final Ref ref;
  OrderDetailsFunctions({required this.ref});
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

  // get buildStep => _buildSteps;

  Future<void> printReceipt(order) async {
    final doc = ps.Document();
    final image = await imageFromAssetBundle(
      LifestyleStrings.whiteLogoImage,
    );
    doc.addPage(
      ps.Page(
        pageFormat: PdfPageFormat.a4,
        build: (ps.Context context) {
          return buildPrintableReciept(image: image, order: order);
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (pdfPageFormat) => doc.save());
  }

  ps.Center buildPrintableReciept({required image, required order}) {
    return ps.Center(
      child: ps.Container(
        color: PdfColor.fromInt(LifestyleColors.kTaupeBackground.value),
        padding: ps.EdgeInsets.all(3.w),
        margin: ps.EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: ps.Column(
          crossAxisAlignment: ps.CrossAxisAlignment.center,
          children: [
            receitLogo(image),
            receitTitleText(),
            ps.SizedBox(
              height: 2.h,
            ),
            receitOrderDetails(order),
            ps.SizedBox(
              height: 2.h,
            ),
            receitProductDetails(order),
            ps.SizedBox(
              height: 2.h,
            ),
            receitCostInfo(order),
            ps.SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  ps.Container receitCostInfo(order) {
    return ps.Container(
      padding: ps.EdgeInsets.all(3.w),
      child: ps.Column(
        children: [
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Shipping fee',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                '0.0',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          ),
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'VAT',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                '0.0',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          ),
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Total',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                order.totalPrice.toString(),
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ps.Container receitProductDetails(order) {
    return ps.Container(
      margin: ps.EdgeInsets.symmetric(horizontal: 3.w),
      child: ps.Column(
        children: order.products.map<ps.Widget>((product) {
          final index = order.products.indexOf(product);
          return ps.Row(
            crossAxisAlignment: ps.CrossAxisAlignment.start,
            children: [
              ps.Expanded(
                child: ps.Column(
                  crossAxisAlignment: ps.CrossAxisAlignment.start,
                  children: [
                    ps.Text(
                      product.name,
                      style: ps.TextStyle(
                        color: PdfColor.fromInt(LifestyleColors.white.value),
                      ),
                    ),
                    ps.Text(
                      product.price.toString(),
                      style: ps.TextStyle(
                        color: PdfColor.fromInt(LifestyleColors.white.value),
                      ),
                    ),
                  ],
                ),
              ),
              ps.Text(
                order.quantity[index].toString(),
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  ps.Container receitOrderDetails(order) {
    return ps.Container(
      padding: ps.EdgeInsets.all(3.w),
      child: ps.Column(
        children: [
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Date',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                '${order.orderTime}',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          ),
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Customer name',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                order.customerName,
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          ),
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Order ID',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                order.id,
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          ),
          ps.Row(
            mainAxisAlignment: ps.MainAxisAlignment.spaceBetween,
            children: [
              ps.Text(
                'Status',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
              ps.Text(
                order.status == 0
                    ? 'Queu'
                    : order.status == 1
                        ? 'In Progress'
                        : order.status == 2
                            ? 'Recieved'
                            : order.status == 3
                                ? 'Completed'
                                : 'Nill',
                style: ps.TextStyle(
                  color: PdfColor.fromInt(LifestyleColors.white.value),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ps.Text receitTitleText() {
    return ps.Text('Purchase Receipt',
        style: ps.TextStyle(
          color: PdfColor.fromInt(LifestyleColors.white.value),
        ));
  }

  ps.Image receitLogo(image) {
    return ps.Image(
      image,
      height: 7.h,
    );
  }
}
