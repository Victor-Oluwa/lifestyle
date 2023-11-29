// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';

class ProviderReference {
  const ProviderReference();

  static CartFunctions cartFunction({required WidgetRef ref}) =>
      ref.watch(cartFunctionProvider);
}
