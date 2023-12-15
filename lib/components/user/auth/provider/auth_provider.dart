import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/user/auth/functions/auth_functions.dart.dart';

import '../../../../state/providers/actions/provider_operations.dart';

// final authFunctionProvider = Provider((ref) => AuthFunctions(ref));

final authFunctionsProvider = Provider.family((ref, BuildContext context) {
  return AuthFunction(ref: ref, chiefContext: context);
});

final getUserDataProvider = FutureProvider((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getUserData();
});
