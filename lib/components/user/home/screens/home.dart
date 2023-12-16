import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/home/widgets/cart_badge_widget.dart';
import 'package:lifestyle/components/user/home/widgets/category_page_indicator.dart';
import 'package:lifestyle/components/user/home/widgets/home_logo_widget.dart';
import 'package:lifestyle/components/user/search/widget/search_widget.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/models-classes/user.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/categories_widget.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late TextEditingController _homeSearchTextController;
  late PageController _pageController;

  @override
  void initState() {
    _homeSearchTextController = TextEditingController();
    _pageController = PageController(viewportFraction: 0.8);

    _pageController.addListener(() {
      pageListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(pageListener)
      ..dispose();
    _pageController.dispose();
    _homeSearchTextController.dispose();

    super.dispose();
  }

  ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  void pageListener() {
    pageNotifier.value = _pageController.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.watch(userProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLogoAndCartIcon(user),
          SizedBox(height: 5.h),
          buildSearchWidget(),
          SizedBox(height: 5.h),
          buildExploreText(),
          SizedBox(height: 3.h),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CategoriesWidget(
                  roomSelectorNotifier: roomSelectorNotifier,
                  pageController: _pageController,
                  pageNotifier: pageNotifier,
                ),
              ],
            ),
          ),
          // SizedBox(height: 6.h),
          CategoryPageIndicators(
              roomSelectorNotifier: roomSelectorNotifier,
              pageNotifier: pageNotifier),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Container buildLogoAndCartIcon(User user) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HomeLogoWidget(),
          GestureDetector(
              onTap: () =>
                  ref.read(homeFunctionProvider).navigateToCartScreen(),
              child: CartBadgeWidget(
                user: user,
                ref: ref,
                iconData: Icons.notifications,
              )),
        ],
      ),
    );
  }

  Container buildExploreText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: MediumText(
        font: 'Cera-Medium',
        text: 'EXPLORE',
        size: 18.sp,
        color: Colors.white,
      ),
    );
  }

  SizedBox buildSearchWidget() {
    return SizedBox(
      child: SearchWidget(
        submmit: (value) {
          final query = value.trim();
          ref.read(homeFunctionProvider).navigateToSearchScreen(query);
        },
        pressed: () {
          final String query = _homeSearchTextController.text.trim();

          ref.read(homeFunctionProvider).navigateToSearchScreen(query);
        },
        controller: _homeSearchTextController,
        ref: ref,
      ),
    );
  }
}
