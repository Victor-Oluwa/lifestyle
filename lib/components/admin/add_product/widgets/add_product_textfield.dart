import 'package:flutter/material.dart';
import 'package:lifestyle/Common/widgets/custom_textfield.dart';
import 'package:lifestyle/components/admin/add_product/function/add_product_functions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProductTextFields extends StatelessWidget {
  const AddProductTextFields({
    super.key,
    required this.addProductFunction,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.quantityController,
  });
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController quantityController;

  final AddProductFunctions addProductFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            controller: nameController,
            label: 'Product',
            hintText: 'Product Name'),
        SizedBox(
          height: 2.5.h,
        ),
        CustomTextField(
            maxLines: 7,
            controller: descriptionController,
            label: 'Description',
            hintText: 'Description'),
        SizedBox(
          height: 2.5.h,
        ),
        CustomTextField(
          textInputType: TextInputType.number,
          controller: priceController,
          label: 'Price',
          hintText: 'Price',
        ),
        SizedBox(
          height: 2.5.h,
        ),
        CustomTextField(
            textInputType: TextInputType.number,
            controller: quantityController,
            label: 'Quantity',
            hintText: 'Quantity'),
      ],
    );
  }
}
