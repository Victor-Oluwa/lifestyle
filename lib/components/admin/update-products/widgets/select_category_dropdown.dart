// import 'package:flutter/Material.dart';
// import 'package:flutter/widgets.dart';

// import '../functions/update_product_fuction.dart';

// class CategoryDropdown extends StatefulWidget {
//   const CategoryDropdown({
//     Key? key,
//     required this.updateProductFunction,
//   }) : super(key: key);
//   final UpdateProductFunction updateProductFunction;

//   @override
//   State<CategoryDropdown> createState() => _CategoryDropdownState();
// }

// class _CategoryDropdownState extends State<CategoryDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: DropdownButton(
//         hint: const Text('Choose Category'),
//         disabledHint: const Text('Choose Category'),
//         icon: const Icon(Icons.keyboard_arrow_down),
//         value: widget.updateProductFunction.productCategory,
//         items: widget.updateProductFunction.productCategories
//             .map((String category) {
//           return DropdownMenuItem(
//             value: category,
//             child: Text(category),
//           );
//         }).toList(),
//         onChanged: ((String? newVal) {
//           setState(() {
//             widget.updateProductFunction.productCategory = newVal!;
//           });
//         }),
//       ),
//     );
//   }
// }
