// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifestyle/components/admin/update-products/functions/update_product_fuction.dart';
import 'package:lifestyle/components/admin/update-products/provider/update_product_provider.dart';
import 'package:lifestyle/models-classes/product.dart';

class UpdateProductCategoryWidget extends StatefulWidget {
  const UpdateProductCategoryWidget({
    Key? key,
    required this.updateProductFunction,
    required this.ref,
    required this.product,
  }) : super(key: key);
  final UpdateProductFunction updateProductFunction;
  final WidgetRef ref;
  final Product product;

  @override
  State<UpdateProductCategoryWidget> createState() =>
      _UpdateProductCategoryWidgetState();
}

class _UpdateProductCategoryWidgetState
    extends State<UpdateProductCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final productCategory = widget.ref.watch(updateProductCategoryProvider);

    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text('Choose Category'),
        disabledHint: const Text('Choose Category'),
        icon: const Icon(Icons.keyboard_arrow_down),
        value: productCategory,
        items: widget.updateProductFunction.productCategories
            .map((String mappedItem) {
          return DropdownMenuItem(
            value: mappedItem,
            child: Text(mappedItem),
          );
        }).toList(),
        onChanged: ((String? newVal) {
          widget.ref.read(updateProductCategoryProvider.notifier).state =
              newVal!;
        }),
      ),
    );
  }
}
