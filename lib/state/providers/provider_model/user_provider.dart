import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/user.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(
          User(
              id: '',
              name: '',
              password: '',
              email: '',
              address: '',
              type: '',
              token: '',
              picture: '',
              cart: []),
        );

  void updateUserFromMap({required Map<String, dynamic> user}) {
    state = User.fromMap(user);
  }

  void updateUserFromJson({required String user}) {
    state = User.fromJson(user);
  }

  void updateAddress({required String address}) {
    state = state.copyWith(address: address);
  }

  void updateToken({required String token}) {
    state = state.copyWith(token: token);
  }

  String updateProfilePicture({required String picture}) {
    state = state.copyWith(picture: picture);
    log('I just got updated');
    return state.picture;
  }

  void updateCart({required List cart}) {
    state = state.copyWith(cart: cart);
  }

  void updatePhone({required String value}) {
    state = state.copyWith(phone: value);
  }
}
