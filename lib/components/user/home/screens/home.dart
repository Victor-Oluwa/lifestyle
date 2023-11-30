import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/home/widgets/cart_badge_widget.dart';
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
  final TextEditingController homeSearchTextController =
      TextEditingController();
  @override
  void dispose() {
    homeSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 6, vsync: this);
    final User user = ref.watch(userProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLogoAndCartIcon(user),
                      SizedBox(height: 5.h),
                      buildSearchWidget(),
                    ]),
              ),
              SizedBox(
                height: 4.5.h,
              ),
              buildExploreText(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, left: 6.w, right: 5.w),
                child: CategoriesWidget(tabController: tabController),
              ),
            ],
          ),
        ),
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

  SearchWidget buildSearchWidget() {
    return SearchWidget(
      submmit: (value) {
        final query = value.trim();
        ref.read(homeFunctionProvider).navigateToSearchScreen(query);
      },
      pressed: () {
        final String query = homeSearchTextController.text.trim();

        ref.read(homeFunctionProvider).navigateToSearchScreen(query);
      },
      controller: homeSearchTextController,
      ref: ref,
    );
  }
}
