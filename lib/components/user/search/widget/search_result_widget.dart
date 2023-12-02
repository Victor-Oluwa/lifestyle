import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/user/search/widget/search_result_template.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../state/providers/actions/provider_operations.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.ref,
    required this.data,
    required this.controller,
  });
  final List<Product> data;
  final WidgetRef ref;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(searchFunctionProvider)
                        .navigateToProductDetailsScreen(data[index]);
                  },
                  child: SearchedResultTemplate(
                    product: data[index],
                  ),
                );
              }),
        )
      ],
    );
  }
}
