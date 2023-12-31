// ignore_for_file: unnecessary_const

// import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/user/home/screens/home.dart';
import 'package:lifestyle/Common/widgets/custom_icon0_icons.dart';
import 'package:lifestyle/components/user/profile/widgets/user_image_and_side_icon_widget.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../Documents/screens/document_view.dart';
import '../../ar/screen/ar_blank_page.dart';
import '../../notification/function/notification_function.dart';
import '../../notification/screen/demo_noti.dart';
import '../../profile/screens/profile_page.dart';

class TabPage extends ConsumerStatefulWidget {
  const TabPage({super.key});

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  @override
  void didChangeDependencies() {
    final NotificationFunction notificationFunction =
        ref.read(notificationFunctionProvider);
    final paystackFunction = ref.read(paystackFunctionsProvider);

    notificationFunction.initNotification();
    paystackFunction.startPaystark();

    super.didChangeDependencies();
  }

  List pages = [
    const HomePage(),
    const DocumentsView(),
    // const ArBlankPage((),
    const NotificationScreen(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

  onTap(index) {
    setState(() {
      currentIndex = index;
      log('Current index $currentIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17.sp),
                topRight: Radius.circular(17.sp))),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            currentIndex: currentIndex,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            elevation: 0,
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(fontFamily: 'CeraThin'),
            unselectedLabelStyle: const TextStyle(fontFamily: 'CeraThin'),
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                activeIcon: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(),
                    child: ShadowIcon(
                      icon: Icons.home,
                      size: 30.sp,
                      color: LifestyleColors.kTaupeBackground,
                      shadowLightColor: LifestyleColors.black,
                    )),
                icon: ShadowIcon(
                  icon: Icons.home,
                  size: 30.sp,
                  color: LifestyleColors.kTaupeBackground,
                  shadowLightColor: LifestyleColors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(),
                    child: ShadowIcon(
                      icon: Icons.folder,
                      size: 30.sp,
                      color: LifestyleColors.kTaupeBackground,
                      shadowLightColor: LifestyleColors.black,
                    ),
                  ),
                  icon: ShadowIcon(
                    icon: Icons.folder,
                    size: 30.sp,
                    color: LifestyleColors.kTaupeBackground,
                    shadowLightColor: LifestyleColors.black,
                  ),
                  label: 'Docs'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(),
                    child: ShadowIcon(
                      icon: Icons.zoom_in_map_outlined,
                      size: 30.sp,
                      color: LifestyleColors.kTaupeBackground,
                      shadowLightColor: LifestyleColors.black,
                    ),
                  ),
                  icon: ShadowIcon(
                    icon: Icons.zoom_in_map_outlined,
                    size: 30.sp,
                    color: LifestyleColors.kTaupeBackground,
                    shadowLightColor: LifestyleColors.black,
                  ),
                  label: 'AR Mode'),
              BottomNavigationBarItem(
                activeIcon: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: const BoxDecoration(),
                  child: ShadowIcon(
                    icon: Icons.person_2,
                    size: 30.sp,
                    color: LifestyleColors.kTaupeBackground,
                    shadowLightColor: LifestyleColors.black,
                  ),
                ),
                icon: ShadowIcon(
                  icon: Icons.person_2,
                  size: 30.sp,
                  color: LifestyleColors.kTaupeBackground,
                  shadowLightColor: LifestyleColors.black,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
