// import 'package:flutter/material.dart';
// import 'package:lifestyle/Common/medium_text.dart';
// import 'package:lifestyle/Common/small_text.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class ExpandableText extends StatefulWidget {
//   const ExpandableText({super.key, required this.text});

//   final String text;

//   @override
//   State<ExpandableText> createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   late String firsthalf;
//   late String secondHalf;

//   double textHeight = 5.63.h;

//   bool hiddenText = true;

//   @override
//   void initState() {
//     if (widget.text.length > textHeight) {
//       firsthalf = widget.text.substring(0, textHeight.toInt());
//       secondHalf =
//           widget.text.substring(textHeight.toInt() + 1, widget.text.length);
//     } else {
//       firsthalf = widget.text;
//       secondHalf = '';
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: secondHalf.isEmpty
//             ? MediumText(text: firsthalf)
//             : Column(
//                 children: [
//                   MediumText(
//                       text: hiddenText
//                           ? ('$firsthalf...')
//                           : (firsthalf + secondHalf)),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         hiddenText = !hiddenText;
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         SmallText(text: hiddenText ? 'Show more' : 'Show less'),
//                         Icon(
//                           hiddenText
//                               ? Icons.arrow_drop_down
//                               : Icons.arrow_drop_up,
//                           color: Colors.grey,
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ));
//   }
// }
