// ignore_for_file: unnecessary_const

// import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/components/user/home/screens/home.dart';
import 'package:lifestyle/Common/widgets/custom_icon0_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../Documents/screens/document_page.dart';
import '../../ar/screen/ar_blank_page.dart';
import '../../notification/function/notification_function.dart';
import '../../profile/screens/profile_page.dart';

class TabPage extends ConsumerStatefulWidget {
  const TabPage({super.key});

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  @override
  void initState() {
    final NotificationFunction notificationFunction =
        ref.read(notificationFunctionProvider);
    notificationFunction.initNotification();
    final paystackFunction = ref.read(paystackFunctionsProvider);
    paystackFunction.startPaystark();
    super.initState();
  }

  List pages = [
    const HomePage(),
    const Documents(),
    const ArBlankPage(),
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
      backgroundColor: lightTaupe,
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
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 23.sp,
                  ),
                ),
                icon: Icon(
                  Icons.home,
                  color: const Color(0xFF675E57),
                  size: 23.sp,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: const BoxDecoration(),
                      child: const Icon(
                        CustomIcon0.doctext,
                        color: Colors.white,
                      )),
                  icon: const Icon(
                    CustomIcon0.doctext,
                    color: Color(0xFF675E57),
                  ),
                  label: 'Docs'),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      height: 4.h,
                      'images/ARw.png',
                    ),
                  ),
                  icon: Image.asset(
                    height: 4.h,
                    'images/ARb.png',
                  ),
                  label: 'AR Mode'),
              BottomNavigationBarItem(
                activeIcon: Container(
                  padding: EdgeInsets.all(1.sp),
                  decoration: const BoxDecoration(),
                  child: Icon(
                    CustomIcon0.useroutline,
                    color: Colors.white,
                    size: 21.sp,
                  ),
                ),
                icon: Icon(
                  CustomIcon0.useroutline,
                  color: const Color(0xFF675E57),
                  size: 21.sp,
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
