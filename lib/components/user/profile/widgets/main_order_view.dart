// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../function/profile_functions.dart';

class OrderPageView extends StatelessWidget {
  const OrderPageView({
    Key? key,
    required this.profileFunctions,
    required this.ref,
  }) : super(key: key);

  final ProfileFunctions profileFunctions;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return profileFunctions.buildUserOrderView(
        ref: ref, profileFunctions: profileFunctions);
  }
}
