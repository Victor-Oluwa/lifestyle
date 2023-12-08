import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/components/admin/add_product/provider/add_product_provider.dart';
import 'package:lifestyle/components/admin/add_product/widgets/add_product_image_field.dart';
import 'package:lifestyle/components/admin/add_product/widgets/add_product_model_field.dart';
import 'package:lifestyle/components/admin/add_product/widgets/add_product_textfield.dart';
import 'package:lifestyle/components/admin/add_product/widgets/add_product_upload_btn.dart';
import 'package:lifestyle/components/admin/add_product/widgets/selece_product_category_dropdown.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/medium_text.dart';

final firebaseCustomTokenProvider = StateProvider((ref) => '');

final isUploadingProvider = StateProvider((ref) => false);

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController quantityController;

  @override
  void initState() {
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    /*Invalidate product image and model providers
    to make them empty so that the data they may contain 
    won't be used for the next product being uploaded*/
    ref.invalidate(addProductImageProvider);
    ref.invalidate(addProductModelProvider);

    /*Invalidate the uploading indicator provider
     to reset it's value to default false so that
     when the back button is pressed before an upload completes
     the progress indicator won't remain active when user returns
     to upload screen*/
    ref.invalidate(isUploadingProvider);
    super.didChangeDependencies();
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
    // Used Providers Declaration
    final isUploading = ref.watch(isUploadingProvider);
    final addProductFunction = ref.watch(addProductFunctionProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: MediumText(
          text: 'Add New Product',
          color: Colors.white,
          size: 16.sp,
        ),
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Form(
                      key: addProductFunction.addProductFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () {
                                addProductFunction.selectImages();
                              },
                              child: AddProductImageField(
                                ref: ref,
                                addProductFunction: addProductFunction,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            GestureDetector(
                              onTap: () {
                                addProductFunction.selectModels();
                              },
                              child: const AddProductModelField(),
                            ),
                            SizedBox(height: 2.5.h),
                            AddProductTextFields(
                              nameController: productNameController,
                              priceController: priceController,
                              descriptionController: descriptionController,
                              quantityController: quantityController,
                              addProductFunction: addProductFunction,
                            ),
                            SelectCategoryDropdown(
                              addProductFunction: addProductFunction,
                            ),
                            SizedBox(height: 2.5.h),
                            InkWell(
                              onTap: () {
                                addProductFunction.addProduct(
                                  context: context,
                                  name: productNameController.text.trim(),
                                  price: priceController.text,
                                  description:
                                      descriptionController.text.trim(),
                                  inStock: quantityController.text,
                                );
                              },
                              child: const AddProductUploadButton(),
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
              /*Shows the uploading indicator
              if isUploading value is true */
              addProductFunction.showUploadingProgressIndicator(isUploading),
            ],
          ),
        ),
      ),
    );
  }
}
