// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifestyle/components/admin/update-products/functions/update_product_fuction.dart';
import 'package:lifestyle/components/admin/update-products/provider/update_product_provider.dart';

import '../../../../models-classes/product.dart';

class ProductStatusDropdown extends StatefulWidget {
  const ProductStatusDropdown({
    Key? key,
    required this.updateProductFunction,
    required this.product,
    required this.ref,
  }) : super(key: key);
  final UpdateProductFunction updateProductFunction;
  final Product product;
  final WidgetRef ref;

  @override
  State<ProductStatusDropdown> createState() => _ProductStatusDropdownState();
}

class _ProductStatusDropdownState extends State<ProductStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    final productStatus = widget.ref.watch(updateProductStatusProvider);
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text('Select Status'),
        disabledHint: const Text('Select Status'),
        icon: const Icon(Icons.keyboard_arrow_down),
        value: productStatus,
        items:
            widget.updateProductFunction.statusOptions.map((String mappedItem) {
          return DropdownMenuItem(
            value: mappedItem,
            child: Text(mappedItem),
          );
        }).toList(),
        onChanged: ((String? newVal) {
          widget.ref.read(updateProductStatusProvider.notifier).state = newVal!;
        }),
      ),
    );
  }
}
