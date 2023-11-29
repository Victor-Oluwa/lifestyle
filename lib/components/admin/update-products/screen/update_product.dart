// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/components/admin/update-products/widgets/update_product_category_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/custom_textfield.dart';
import 'package:lifestyle/components/admin/update-products/widgets/product_status_dropdown.dart';

import '../../../../Common/widgets/medium_text.dart';
import '../../../../Common/widgets/processing_indicator.dart';
import '../../../../core/params/product_upload_params.dart';
import '../../../../core/typeDef/type_def.dart';
import '../../../../models-classes/product.dart';
import '../../add_product/screen/add_product_screen.dart';
import '../provider/update_product_provider.dart';
import '../widgets/update_button.dart';
import '../widgets/update_product_image_field.dart';
import '../widgets/update_product_model_field.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  static const String routeName = '/update-product';

  const UpdateProduct({super.key});

  @override
  ConsumerState<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  Product product = Get.arguments;

  late TEC productNameController;
  late TEC descriptionController;
  late TEC priceController;
  late TEC quantityController;
  final GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    ref.invalidate(updateProductImageProvider);
    ref.invalidate(updateProductModelProvider);
    ref.invalidate(isUploadingProvider);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    productNameController = TEC(text: product.name);
    descriptionController = TEC(text: product.description);
    priceController = TEC(text: product.price.toString());
    quantityController = TEC(text: product.inStock.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUploading = ref.watch(isUploadingProvider);
    final updateProductFunction = ref.read(updateProductFunctionProvider);
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      appBar: buildAppbar(),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Form(
                      key: _addProductFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateProductFunction
                                    .selectImages()
                                    .then((value) => setState(() {}));
                              },
                              child: ImageField(
                                product: product,
                                updateProductFunction: updateProductFunction,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            GestureDetector(
                              onTap: updateProductFunction.selectModels,
                              child: ModelField(
                                product: product,
                                updateProductFunction: updateProductFunction,
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            ...buildTextEditor(),
                            ProductStatusDropdown(
                              ref: ref,
                              product: product,
                              updateProductFunction: updateProductFunction,
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            UpdateProductCategoryWidget(
                              updateProductFunction: updateProductFunction,
                              ref: ref,
                              product: product,
                            ),
                            InkWell(
                              onTap: () {
                                final images =
                                    ref.read(updateProductImageProvider);
                                final models =
                                    ref.read(updateProductModelProvider);
                                final category =
                                    ref.read(updateProductCategoryProvider);
                                final status =
                                    ref.read(updateProductStatusProvider);

                                final params = ProductUploadParams(
                                    id: product.id,
                                    name: productNameController.text,
                                    description: descriptionController.text,
                                    category: category,
                                    status: status,
                                    inStock: int.parse(quantityController.text),
                                    price: double.parse(priceController.text),
                                    images: images,
                                    models: models);
                                updateProductFunction.updateProduct(params,
                                    productFormKey: _addProductFormKey);
                              },
                              child: const UpdateButton(),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isUploading ? const ProcessingIndicator() : const Text('')
        ],
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: LifestyleColors.black,
      // backgroundColor: LifestyleColors.black.withOpacity(0.4),
      title: MediumText(
        text: 'Update Product',
        color: Colors.white,
        size: 16.sp,
      ),
    );
  }

  buildTextEditor() {
    return [
      CustomTextField(
          readOnly: true,
          selection: false,
          controller: productNameController,
          label: 'Edit name',
          hintText: 'Product name'),
      SizedBox(
        height: 2.5.h,
      ),
      CustomTextField(
          maxLines: 7,
          controller: descriptionController,
          label: 'Edit description',
          hintText: 'Description'),
      SizedBox(
        height: 2.5.h,
      ),
      CustomTextField(
          controller: priceController, label: 'Edit price', hintText: 'Price'),
      SizedBox(
        height: 2.5.h,
      ),
      CustomTextField(
          controller: quantityController,
          label: 'Edit Quantity',
          hintText: 'Quantity'),
    ];
  }
}
