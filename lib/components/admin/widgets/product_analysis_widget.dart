import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as chart;
import 'package:lifestyle/models-classes/sales.dart';

import '../../../Common/widgets/app_constants.dart';

class ProductAnalysisWidget extends StatelessWidget {
  final xAxis = chart.OrdinalAxisSpec(
      renderSpec: chart.SmallTickRendererSpec(
          labelStyle: chart.TextStyleSpec(
    fontFamily: comorant,
    color: chart.MaterialPalette.white,
  )));

  final yAxis = chart.NumericAxisSpec(
      renderSpec: chart.GridlineRendererSpec(
          labelStyle: chart.TextStyleSpec(
              color: chart.MaterialPalette.white, fontFamily: comorant)));
  final List<chart.Series<Sales, String>> seriesList;
  ProductAnalysisWidget({
    super.key,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      primaryMeasureAxis: yAxis,
      domainAxis: xAxis,
      seriesList,
      animate: true,
    );
  }
}

// class ProductAnalysisWidget2 extends StatelessWidget {
//   final List<BarChartGroupData> chartData;
//   const ProductAnalysisWidget2({
//     super.key,
//     required this.chartData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(

//       BarChartData(
        
//           borderData: FlBorderData(
//             border: const Border(
//               top: BorderSide.none,
//               right: BorderSide.none,
//               left: BorderSide(width: 1),
//               bottom: BorderSide(width: 1),
//             ),
//           ),
//           groupsSpace: 10,
          
//           barGroups: chartData),
//     );
//   }
// }


//  [
//             BarChartGroupData(x: 1, barRods: [
//               BarChartRodData(toY: 10, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 2, barRods: [
//               BarChartRodData(toY: 9, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 3, barRods: [
//               BarChartRodData(toY: 4, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 4, barRods: [
//               BarChartRodData(toY: 2, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 5, barRods: [
//               BarChartRodData(toY: 13, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 6, barRods: [
//               BarChartRodData(toY: 17, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 7, barRods: [
//               BarChartRodData(toY: 19, width: 15, color: Colors.amber),
//             ]),
//             BarChartGroupData(x: 8, barRods: [
//               BarChartRodData(toY: 21, width: 15, color: Colors.amber),
//             ]),
//           ]