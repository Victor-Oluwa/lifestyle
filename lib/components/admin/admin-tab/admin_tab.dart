import 'package:flutter/material.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/components/admin/orders/screen/order_screen.dart';
import 'package:lifestyle/components/admin/all-products/screen/all_products_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../user/notification/screen/announcement_screen.dart';
import '../all-products/widget/box_button.dart';

class AdminTab extends StatefulWidget {
  const AdminTab({super.key});

  @override
  State<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  List pages = [
    const AllProductsScreen(),
    const OrdersScreen(),
    const Announcement()
  ];
  int currentIndex = 0;
  onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTaupe,
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.red.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12.sp)),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            backgroundColor: lightTaupe,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            currentIndex: currentIndex,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            elevation: 0,
            showSelectedLabels: false,
            items: [
              //Orders
              BottomNavigationBarItem(
                activeIcon: BoxButton(
                  icon: Icon(
                    Icons.house_outlined,
                    size: 24.sp,
                  ),
                ),
                icon: Icon(
                  Icons.house_outlined,
                  size: 24.sp,
                ),
                label: '',
              ),
              // BottomNavigationBarItem(
              //     activeIcon: BoxButton(
              //       icon: Icon(
              //         Icons.analytics_outlined,
              //         size: 22.sp,
              //       ),
              //     ),
              //     icon: Icon(
              //       Icons.analytics_outlined,
              //       size: 22.sp,
              //     ),
              //     label: ''),
              BottomNavigationBarItem(
                  activeIcon: BoxButton(
                    icon: Icon(
                      Icons.archive_outlined,
                      size: 22.sp,
                    ),
                  ),
                  icon: Icon(
                    Icons.archive_outlined,
                    size: 22.sp,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  activeIcon: BoxButton(
                    icon: Icon(
                      Icons.announcement_outlined,
                      size: 22.sp,
                    ),
                  ),
                  icon: Icon(
                    Icons.announcement_outlined,
                    size: 22.sp,
                  ),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
