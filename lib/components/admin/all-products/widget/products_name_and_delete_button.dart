import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';

class NameAndDeleteIcon extends StatelessWidget {
  const NameAndDeleteIcon({
    super.key,
    required this.index,
    required this.product,
    required this.ref,
  });
  final int index;
  final WidgetRef ref;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final allProductsFunctions = ref.read(allProductsFunctionProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: MediumText(
            font: comorant,
            overflow: TextOverflow.ellipsis,
            text: product.name,
          ),
        ),
        InkWell(
          onTap: () => allProductsFunctions.deleteProduct(product),
          child: const Icon(Icons.delete),
        )
      ],
    );
  }
}
