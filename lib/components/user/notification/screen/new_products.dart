import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/widgets/medium_text.dart';

class NewProductsScreen extends ConsumerStatefulWidget {
  const NewProductsScreen({super.key});

  @override
  ConsumerState<NewProductsScreen> createState() => _NewProductsScreenState();
}

class _NewProductsScreenState extends ConsumerState<NewProductsScreen> {
  List<Product> products = [];
  List<Product> newProducts = [];

  getNewProducts() async {
    final adminServices = ref.read(allProductsProvider);
    products = await adminServices.fetchAllProduct();
    // final DateTime currentDate = DateTime.now();
    DateTime createdAt;
    for (var product in products) {
      String dateInString = product.createdAt;
      if (dateInString != '') {
        createdAt = DateTime.parse(dateInString);
        Duration difference = DateTime.now().difference(createdAt);
        if (difference.inDays <= 30) {
          newProducts.add(product);
        }
      }
    }
    setState(() {});
  }

  String removeExtraSpaces(String text) {
    final pattern = RegExp('\\s+');
    return text.replaceAll(pattern, ' ');
  }

  void navigateToDetailsScreen(Product selectedProduct) {
    Get.toNamed(LifestyleRouteName.productDetailRoute,
        arguments: selectedProduct);
  }

  @override
  void initState() {
    getNewProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final RemoteMessage message = Get.arguments;
    return Scaffold(
      backgroundColor: const Color(0xFFB0A291),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: MediumText(text: 'New Products'.toUpperCase()),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: newProducts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateToDetailsScreen(newProducts[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 2.h, left: 2.w),
                              height: 19.h,
                              width: 19.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          newProducts[index].images[0])),
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                            // color: Colors.green,
                            padding: const EdgeInsets.only(),
                            width: 50.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MediumText(
                                    text:
                                        '${newProducts[index].name.toUpperCase()} (${newProducts[index].category})'),
                                SizedBox(height: 0.5.h),
                                Row(
                                  children: [
                                    Text(
                                      '₦',
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    MediumText(
                                        size: 16.sp,
                                        text: '${newProducts[index].price}'),
                                  ],
                                ),
                                SizedBox(height: 0.5.h),
                                MediumText(
                                  size: 15.sp,
                                  text: removeExtraSpaces(
                                      newProducts[index].description),
                                  maxLine: 4,
                                ),
                                SizedBox(height: 0.5.h),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.h,
                                  width: 25.w,
                                  color: Colors.black,
                                  child: MediumText(
                                    text: 'Add To Cart',
                                    size: 15.sp,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
