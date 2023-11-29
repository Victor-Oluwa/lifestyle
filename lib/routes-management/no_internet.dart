// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../Common/general/medium_text.dart';

// class NoInternet extends StatefulWidget {
//   const NoInternet({super.key});

//   @override
//   State<NoInternet> createState() => _NoInternetState();
// }

// class _NoInternetState extends State<NoInternet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: const Color(0xFF675E57),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration:
//                     BoxDecoration(border: Border.all(color: Colors.white)),
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
//                 margin: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: MediumText(
//                   font: 'Comorant-Light',
//                   overflow: TextOverflow.visible,
//                   text:
//                       'Could not confirm user. Kindly check your internet connection and try again'
//                           .toUpperCase(),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
