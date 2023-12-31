import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/components/user/home/widgets/cart_badge_widget.dart';
import 'package:lifestyle/components/user/home/widgets/category_page_indicator.dart';
import 'package:lifestyle/components/user/home/widgets/home_logo_widget.dart';
import 'package:lifestyle/components/user/search/widget/search_widget.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:socket_io_client/socket_io_client.dart' as suk;

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Common/widgets/app_constants.dart';
import '../../../../state/providers/provider_model/notification_provider.dart';
import '../../auth/screen/init_screen.dart';
import '../widgets/product_category_page_view.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late suk.Socket socket;
  String userid = "";
  late TextEditingController _homeSearchTextController;
  late PageController _pageController;

  @override
  void initState() {
    ref.read(homeFunctionProvider).getNotifications();
    _homeSearchTextController = TextEditingController();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      pageListener();
    });

    socket = suk.io(
      uri,
      suk.OptionBuilder().setTransports(['websocket']).build(),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final notifyProvider = ref.watch(notificationProvider);

    socket.onConnect((data) {
      log('Socket connected');
      socket.on('notifi_cations', (data) {
        if (data != null) {
          final userId = ref.read(userProvider).id;
          data.forEach((noti) {
            if (noti['userId'] == userId) {
              if (!notifyProvider.contains(noti)) {
                ref
                    .read(notificationProvider.notifier)
                    .updateNotificationFromMapList(data);
              }
            }
          });
        }
      });
    });

    socket.connect();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(pageListener)
      ..dispose();
    _homeSearchTextController.dispose();
    socket.dispose();

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
                  ref.read(homeFunctionProvider).navigateToNotifications(),
              child: CartBadgeWidget(
                user: user,
                ref: ref,
                iconData: Icons.notifications,
              )),
        ],
      ),
    );
  }

  buildExploreText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 5.w),
      child: NeumorphicText(
        'EXPLORE',
        textStyle: NeumorphicTextStyle(
          fontSize: 20.sp,
          fontFamily: LifestyleFonts.kComorantBold,
        ),
        style: const NeumorphicStyle(
          shadowLightColor: Colors.black26,
          intensity: 100,
          depth: 1,
          color: LifestyleColors.kTaupeBackground,
        ),
      ),
    );

    //   return Container(
    //   alignment: Alignment.centerLeft,
    //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
    //   child: MediumText(
    //     font: 'Cera-Medium',
    //     text: 'EXPLORE',
    //     size: 18.sp,
    //     color: Colors.white,
    //   ),
    // );
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
