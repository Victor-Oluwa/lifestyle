// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:lifestyle/core/error/exception/api_exception.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/models-classes/notifications.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/models-classes/user.dart';

import '../../../../state/providers/provider_model/notification_provider.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class HomeServices {
  final Ref ref;
  HomeServices({
    required this.ref,
  });
  int index = Random().nextInt(1000) + 50;

  Future<List<Product>> fetchProductCategory({required String category}) async {
    final User userNotifier = ref.read(userProvider);
    List<Product> result = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userNotifier.token,
      });

      if (res.statusCode == 200 || res.statusCode == 201) {
        result = (jsonDecode(res.body) as List)
            .map((product) => Product.fromMap(product))
            .toList();
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dev.log('Error: Could not get category: ${e.message}');
    } on SocketException {
      //implement
    } catch (e) {
      dev.log(e.toString());
    }
    return result;
  }

  Future<String> changeProfilePicture({
    required User user,
    required List<File> picture,
  }) async {
    String newPicture = '';
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final User userNotifier = ref.read(userProvider);
      List<String> imageUrls = [];

      for (var file in picture) {
        final Reference ref = storage
            .ref()
            .child('Users/${user.email}/Profile_picture/${user.id}');
        final UploadTask task = ref.putFile(File(file.path));
        final TaskSnapshot snapshot =
            await task.whenComplete(() => dev.log('Image Uploaded'));
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        dev.log('ImageUrls: $imageUrls');
      }

      http.Response res = await http.put(
        Uri.parse('$uri/api/change/profile-picture'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: userNotifier.token,
        },
        body: jsonEncode(
          {
            'id': user.id,
            'image': imageUrls[0],
          },
        ),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        dev.log('Got Here1');

        final User user = User.fromMap(jsonDecode(res.body));
        newPicture = ref
            .read(userProvider.notifier)
            .updateProfilePicture(picture: user.picture);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage('ATTENTION', 'Picture update was unsuccessfull');
      dev.log(
          'Failed to update profile picture: ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dev.log('Failed to update profile picture: $e');
    }
    return newPicture;
  }

  Future<void> getNotifications() async {
    try {
      final user = ref.read(userProvider);
      final http.Response response = await http
          .get(Uri.parse('$uri/user/notifications/${user.id}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      if (response.statusCode == 200) {
        List<Notifications> notifications =
            List<Map<String, dynamic>>.from(jsonDecode(response.body) as List)
                .map((notification) => Notifications.fromMap(notification))
                .toList();

        ref
            .read(notificationProvider.notifier)
            .updateNotification(notifications);
      } else {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException catch (e) {
      dev.log('Failed to get user notification $e');
    } catch (e) {
      dev.log('Failed to get user notification: Something went wrong: $e');
    }
  }
}
