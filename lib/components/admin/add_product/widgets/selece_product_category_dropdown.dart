import 'package:flutter/material.dart';
import 'package:lifestyle/components/admin/add_product/function/add_product_functions.dart';

class SelectCategoryDropdown extends StatefulWidget {
  final AddProductFunctions addProductFunction;
  const SelectCategoryDropdown({super.key, required this.addProductFunction});

  @override
  State<SelectCategoryDropdown> createState() => _SelectCategoryDropdownState();
}

class _SelectCategoryDropdownState extends State<SelectCategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text('Choose Category'),
        disabledHint: const Text('Choose Category'),
        icon: const Icon(Icons.keyboard_arrow_down),
        value: widget.addProductFunction.category,
        items: widget.addProductFunction.productCategories
            .map((String mappedItem) {
          return DropdownMenuItem(
            value: mappedItem,
            child: Text(mappedItem),
          );
        }).toList(),
        onChanged: ((String? newVal) {
          setState(() {
            widget.addProductFunction.setCategory = newVal!;
          });
        }),
      ),
    );
  }
}
