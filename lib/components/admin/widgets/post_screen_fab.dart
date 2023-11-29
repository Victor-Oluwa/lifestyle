import 'package:flutter/material.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/components/admin/all-products/functions/all_products_function.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.postScreenFunctoin,
  });

  final AllProductFunctions postScreenFunctoin;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add Product',
      backgroundColor: taupe,
      onPressed: postScreenFunctoin.navigateToAddProduct,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
