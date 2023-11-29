// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/user/profile/widgets/empty_orders_pageview_widget.dart';

import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/components/user/home/services/home_services.dart';
import 'package:lifestyle/core/connectivity/provider/connectivity_provider.dart';
import 'package:lifestyle/core/error/widgets/no_internet_widget.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../Common/widgets/loading_indicator.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';
import '../../home/provider/home_provider.dart';
import '../services/profile_services.dart';
import '../widgets/main_profile_view.dart';
import '../widgets/orders_pageview_widget.dart';

class ProfileFunctions {
  ProfileFunctions({required this.ref});
  final Ref ref;

  String profilePicture = '';
  List<Order>? orders;
  final List<File> _image = [];
  get image => _image;

  Future<List<File>> pickProfilePicture() async {
    return await pickImage();
  }

  Future<String> updateProfile({required User user}) async {
    final HomeServices homeServices = ref.read(homeServiceProvider);
    return await pickProfilePicture().then((value) async {
      if (value == [] || value.isEmpty) {
        return '';
      }
      return await homeServices.changeProfilePicture(
        user: user,
        picture: value,
      );
    });
  }

  String getuserPic() {
    return ref.watch(userProvider).picture;
  }

  void logOut() {
    final ProfileServices profileServices = ref.read(profileServicesProvider);
    profileServices.logOut();
  }

  Future<List<Order>> fetchOrders() async {
    final ProfileServices profileServices = ref.read(profileServicesProvider);
    return await profileServices.fetchMyOrders();
  }

  void navigateOrderDetailsScreen(Order order) {
    Get.toNamed(LifestyleRouteName.orderDetailsRoute, arguments: order);
  }

  DecorationImage loadUserPicture() {
    if (getuserPic() == '' || getuserPic().isEmpty) {
      return const DecorationImage(
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
        image: AssetImage('images/defaultProfilePic.jpeg'),
      );
    }
    return DecorationImage(
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
      image: NetworkImage(getuserPic()),
    );
  }

  Future<bool> checkInternetConnection() async {
    final connectivityService = ref.read(connectivityServiceProvider);
    return connectivityService.checkInternetConnection().then((state) {
      return ref.read(isConnected.notifier).state = state;
    });
  }

  Widget buildProfileMainView({
    required ProfileFunctions profileFunction,
    required WidgetRef ref,
  }) {
    checkInternetConnection();
    final connected = ref.watch(isConnected);
    return buildMainView(
        profileFunction: profileFunction, ref: ref, internet: connected);
  }

  Widget buildMainView({
    required ProfileFunctions profileFunction,
    required WidgetRef ref,
    required bool internet,
  }) {
    if (internet) {
      final user = ref.read(userProvider);
      return ProfileMainBody(
        ref: ref,
        profileFunctions: profileFunction,
        user: user,
      );
    } else {
      return NoInternetWidget(
        onRefresh: () {
          log('message');
          checkInternetConnection();
        },
      );
    }
  }

  Widget buildUserOrderView(
      {required WidgetRef ref, required ProfileFunctions profileFunctions}) {
    checkInternetConnection();
    final connected = ref.watch(isConnected);
    return buildOrderView(
        internet: connected, ref: ref, profileFunctions: profileFunctions);
  }

  Widget buildOrderView(
      {required bool internet,
      required WidgetRef ref,
      required ProfileFunctions profileFunctions}) {
    if (internet) {
      return ref.watch(fetchOrdersProvider).when(data: (data) {
        bool isEmpty = data.isEmpty || data == [];
        switch (isEmpty) {
          case false:
            return OrdersPageviewWidget(
              orders: data,
              profileFunctions: profileFunctions,
            );
          case true:
            return const EmptyOrdersPageviewWidget();

          default:
            return const EmptyOrdersPageviewWidget();
        }
      }, error: (_, error) {
        return const EmptyOrdersPageviewWidget();
      }, loading: () {
        return const LoadingIndicator();
      });
    } else {
      return NoInternetWidget(
        onRefresh: () {
          log('message');
          checkInternetConnection();
        },
      );
    }
  }
}
