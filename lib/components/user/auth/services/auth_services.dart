// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/Common/widgets/snackbar_messages.dart';
import 'package:lifestyle/core/error/exception/api_exception.dart';
import 'package:lifestyle/Common/widgets/empty_screen.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/common/widgets/utils.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:lifestyle/components/user/home/screens/tab_page.dart';
import 'package:lifestyle/components/admin/admin-tab/admin_tab.dart';

import '../../../../routes-management/lifestyle_routes_names.dart';
import '../../../storage/secure_storage_provider.dart';

class AuthServices {
  final Ref ref;

  AuthServices({
    required this.ref,
  });

  final Dio _dio = Dio();

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        ref
            .read(userProvider.notifier)
            .updateUserFromMap(user: jsonDecode(response.body));
        final user = ref.read(userProvider);

        final secureStorege = ref.read(secureStorageProvider);
        await secureStorege.writeSecureData(AppConstants.authToken, user.token);

        if (user.type == 'user') {
          x.Get.offAll(() => const TabPage());
        } else if (user.type == 'admin') {
          x.Get.offAll(() => const AdminTab());
        } else {
          x.Get.offAll(() => const EmptyScreen(
                color: Colors.transparent,
              ));
        }
      } else {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException catch (e) {
      if (e.statusCode == 101) {
        dropperMessage('ATTENTION', 'Your password is incorrect');
      } else if (e.statusCode == 102) {
        dropperMessage('ATTENTION', 'No user with such email');
      }
      log('Sign In Error $e');
    } catch (e) {
      log('Sign In Error $e');
    }
  }

  // Sign Up
  Future<void> signUpUser({
    required String email,
    required String password,
    required name,
  }) async {
    try {
      User newUser = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        phone: '',
        type: '',
        picture: '',
        token: '',
        cart: [],
      );

      final response = await http.post(
        Uri.parse('$uri/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: newUser.toJson(),
      );

      if (response.statusCode == 200) {
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUserFromMap(user: jsonDecode(response.body));

        final user = ref.read(userProvider);

        final secureStorage = ref.read(secureStorageProvider);
        await secureStorage.writeSecureData(AppConstants.authToken, user.token);

        x.Get.offAll(() => const TabPage());
      } else {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException catch (e) {
      if (e.statusCode == 404) {
        dropperMessage('Account already exists', 'Sign In Instead');
        x.Get.toNamed(LifestyleRouteName.signInRoute);
      } else {
        dropperMessage('An Error Occurred', 'Please try again later');
      }
      log('Failed to signUp user ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      log('Could Not Create Account');
      log('Could Not Create Account: $e');
    }
  }

  //Retrieve Token
  Future<String> retrieveToken() async {
    final secureStorage = ref.read(secureStorageProvider);
    return await secureStorage.readSecureData(AppConstants.authToken) ??
        'empty.token';
  }

  //Verify Token
  Future<bool> verifyToken() async {
    final token = await retrieveToken();
    if (token == '') {
      log('Token is empty string');
    }
    log('Token is valid: $token');
    Response tokenIsValid = await _dio.post(
      '$uri/tokenIsValid',
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {AppConstants.authToken: token},
      ),
    );
    if (tokenIsValid.statusCode == 200 || tokenIsValid.statusCode == 201) {
      return tokenIsValid.data;
    } else {
      throw APIException(
        message: tokenIsValid.data,
        statusCode: tokenIsValid.statusCode ?? 404,
      );
    }
  }

  // getData
  Future<Map<String, dynamic>> getUserData() async {
    final token = await retrieveToken();
    Map<String, dynamic> userLoggedOut = {'status': 'loggedOut'};

    try {
      bool tokenIsValid = await verifyToken();

      if (tokenIsValid == true) {
        Response retrieveUserData = await _dio.get(
          '$uri/',
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {AppConstants.authToken: token},
          ),
        );

        if (retrieveUserData.statusCode == 200 ||
            retrieveUserData.statusCode == 201) {
          final Map<String, dynamic> mapResponse = retrieveUserData.data;

          final String token = mapResponse['token'];
          final Map<String, dynamic> user = mapResponse;

          if (user.isNotEmpty && token.isNotEmpty) {
            final userNotifier = ref.read(userProvider.notifier);
            userNotifier.updateUserFromMap(user: user);
            log('Updated user token: $token');
            userNotifier.updateToken(token: token);
          } else {
            log('User is empty');
          }

          return user;
        } else {
          throw APIException(
              message: retrieveUserData.data,
              statusCode: retrieveUserData.statusCode ?? 1000);
        }
      } else {
        return userLoggedOut;
      }
    } on APIException catch (e) {
      dropperMessage(
        'Verification Failed',
        'Lifestyle could not verify your account at the moment. Try again in a bit',
      );
      log('${e.statusCode} Error: ${e.message}');
      return userLoggedOut;
    } on DioError {
      // log(e.response?.data ?? e.message);
    } catch (e) {
      dropperMessage(kUserVerificationErrorMessage['Title'],
          kUserVerificationErrorMessage['Body']);
      // log('User authentication error: $e');
      return userLoggedOut;
    }

    return userLoggedOut;
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
