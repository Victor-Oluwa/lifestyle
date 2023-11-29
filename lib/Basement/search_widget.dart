// import 'package:flutter/Material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class SearchBox extends StatelessWidget {
//   const SearchBox({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         decoration: const BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: Color(0xFF483C32), blurRadius: 10, spreadRadius: 15),
//           ],
//         ),
//         width: double.infinity,
//         child: Row(
//           children: [
//             const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.transparent,
//             ),
//             SizedBox(
//               width: 4.w,
//             ),
//             Expanded(
//               child: Material(
//                 borderRadius: BorderRadius.circular(7),
//                 elevation: 1,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: InkWell(
//                       onTap: () {},
//                       child: const Icon(
//                         Icons.search,
//                         color: Colors.black,
//                         size: 23,
//                       ),
//                     ),
//                     contentPadding: const EdgeInsets.only(top: 15),
//                     border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(7),
//                         ),
//                         borderSide: BorderSide.none),
//                     enabledBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(7),
//                       ),
//                       borderSide: BorderSide(color: Colors.brown, width: 1),
//                     ),
//                     // hintStyle: TextStyle(fontFamily: 'Cera'),
//                     hintText: 'Search Lifestyle',
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 4.w,
//             ),
//             Icon(
//               Icons.mic,
//               size: 22.sp,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
