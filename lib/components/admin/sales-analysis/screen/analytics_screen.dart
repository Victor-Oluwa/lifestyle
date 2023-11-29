import 'dart:developer';
import 'package:charts_flutter_new/flutter.dart' as chart;
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/sales.dart';
import 'package:lifestyle/components/admin/widgets/product_analysis_widget.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/app_constants.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  dynamic _totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    final salesAnalysisServices = ref.read(salesAnalysisProvider);

    var earningData = await salesAnalysisServices.getEarnings(context);
    //Remove s
    _totalSales = earningData['totalEarning'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (earnings != null) log('Earnings is: ${earnings!}');
    return earnings == null || _totalSales == null
        ? Center(
            child: Image(
                height: 15.h,
                width: 15.h,
                image: const AssetImage('images/toplogo.png')),
          )
        : Scaffold(
            backgroundColor: lightTaupe,
            appBar: AppBar(
              title: MediumText(
                font: comorant,
                text: 'ANALYSIS',
                color: Colors.white,
                size: 16.sp,
              ),
              backgroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MediumText(
                          size: 20.sp,
                          font: comorant,
                          text: 'Total: ',
                          color: Colors.white,
                        ),
                        MediumText(
                          font: 'Cera',
                          color: Colors.white,
                          text: '$_totalSales',
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 4.w, top: 2.h),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       MediumText(
                  //         font: comorant,
                  //         text: 'ANALYSIS',
                  //         color: Colors.white,
                  //         size: 20.sp,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 3.w),
                      child: ProductAnalysisWidget(
                        seriesList: [
                          chart.Series(
                              id: 'Sales',
                              data: earnings!,
                              domainFn: (Sales sales, _) => sales.label,
                              measureFn: (Sales sales, _) => sales.earning)
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                  //   child: Row(
                  //     children: [
                  //       MediumText(
                  //         size: 20.sp,
                  //         font: comorant,
                  //         text: 'Total: ',
                  //         color: Colors.white,
                  //       ),
                  //       MediumText(
                  //         font: 'Cera',
                  //         color: Colors.white,
                  //         text: '$_totalSales',
                  //         size: 18.sp,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 4.h,
                  )
                ],
              ),
            ),
          );
  }
}
