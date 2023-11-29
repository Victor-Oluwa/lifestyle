import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import 'utils.dart'; // Replace 'http' with 'dio'

void httpErrorHandling(
    {required http.Response response,
    //   required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      dropperMessage('ATTENTION', 'An error occurred. Please try again later');

      log(jsonDecode(response.body)['Handler 404 error']);
      break;

    default:
      // showSnackBar(errorMessageTitle, errorMesssage2);

      log(jsonDecode(response.body)['Handler default error']);
  }
}

void dioErrorHandling(
    {required Response response, required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 500:
      (jsonDecode(response.data)['Handler 500 error']);
      break;
    default:
      log(jsonDecode(response.data)['Handler default error']);
  }
}
