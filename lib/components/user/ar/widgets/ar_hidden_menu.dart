import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/global_variables.dart';

class ArHiddenMenu extends ConsumerStatefulWidget {
  const ArHiddenMenu({super.key});

  @override
  ConsumerState<ArHiddenMenu> createState() => _HiddenMenuState();
}

class _HiddenMenuState extends ConsumerState<ArHiddenMenu> {
  List<Product> sofas = [];
  List<Product> armchairs = [];
  List<Product> tables = [];
  List<Product> beds = [];
  List<Product> accessories = [];
  List<Product> lights = [];
  @override
  void initState() {
    log('first category ${GlobalVariables.categoryTitles[0]}');
    // fetchSofa();
    // fetchAccessories();
    // fetchArmChairs();
    // fetchBeds();
    // fetchTables();
    // fetchLight();
    super.initState();
  }

  // fetchSofa() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap = await productCategoriesFunction.fetchCategoryProducts(
  //       category: 'Sofas');
  //   sofas = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  // fetchArmChairs() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap = await productCategoriesFunction.fetchCategoryProducts(
  //       category: 'Armchairs');
  //   armchairs = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  // fetchTables() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap = await productCategoriesFunction.fetchCategoryProducts(
  //       category: 'Tables');
  //   tables = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  // fetchBeds() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap =
  //       await productCategoriesFunction.fetchCategoryProducts(category: 'Beds');
  //   beds = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  // fetchAccessories() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap = await productCategoriesFunction.fetchCategoryProducts(
  //       category: 'Accessories');
  //   accessories = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  // void fetchLight() async {
  //   final productCategoriesFunction =
  //       ref.read(productCategoriesFunctionProvider);
  //   final productAsMap = await productCategoriesFunction.fetchCategoryProducts(
  //       category: 'Lights');
  //   lights = productCategoriesFunction.convertMapToProduct(productAsMap);
  // }

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  logInfo() {
    log('Function Called');
  }

  bool isMenuVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              isMenuVisible = !isMenuVisible;
            });
          }),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.grey,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                // margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
                color: Colors.transparent,
                duration: const Duration(milliseconds: 400),
                height: isMenuVisible
                    ? MediaQuery.of(context).size.height / 1.4
                    : 0,
                child: buildGrid(),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(0);
                    // _pageController.animateToPage(0,
                    //     duration: const Duration(milliseconds: 500),
                    //     curve: Curves.easeIn);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 22.w,
                    height: 4.h,
                    decoration: const BoxDecoration(color: Color(0xFFB0A291)),
                    child: const MediumText(
                      text: 'Categories',
                      color: Colors.black,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGrid() {
    return PageView(controller: _pageController, children: [
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              index == 0
                  ? _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn)
                  : index == 1
                      ? _pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn)
                      : index == 2
                          ? _pageController.animateToPage(3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn)
                          : index == 3
                              ? _pageController.animateToPage(4,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn)
                              : index == 4
                                  ? _pageController.animateToPage(5,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn)
                                  : index == 5
                                      ? _pageController.animateToPage(6,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn)
                                      : _pageController.animateToPage(0,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
            },
            child: Container(
              alignment: Alignment.center,
              height: 20.h,
              width: 10.h,
              margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
              color: Colors.black,
              child: MediumText(text: GlobalVariables.categoryTitles[index]),
            ),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(sofas[index].images[0]))),
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            child: MediumText(
              text: sofas[index].name,
              color: Colors.black,
            ),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            color: Colors.black,
            child: MediumText(
                text: armchairs.isEmpty
                    ? sofas[index].name
                    : armchairs[index].name),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            color: Colors.black,
            child: MediumText(
                text:
                    armchairs.isEmpty ? sofas[index].name : tables[index].name),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            color: Colors.black,
            child: MediumText(
                text: armchairs.isEmpty ? sofas[index].name : beds[index].name),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            color: Colors.black,
            child: MediumText(
                text: armchairs.isEmpty
                    ? sofas[index].name
                    : accessories[index].name),
          );
        },
      ),
      MasonryGridView.count(
        itemCount: GlobalVariables.categoryTitles.length,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        cacheExtent: 100,
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            width: 10.h,
            margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
            color: Colors.black,
            child: MediumText(
                text:
                    armchairs.isEmpty ? sofas[index].name : lights[index].name),
          );
        },
      ),
    ]);
  }
}

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
