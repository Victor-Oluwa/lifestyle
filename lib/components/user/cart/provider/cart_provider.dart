import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';

final getProducQuantityProvider =
    FutureProvider.family((ref, String productId) {
  final cartServices = ref.read(cartServicesProvider);
  return cartServices.getProductQuantity(productId: productId);
});

final productQuantityState =
    StateProvider.family((ref, String productId) async {
  final cartServices = ref.watch(cartFunctionProvider);
  return await cartServices.getProductQuantity(productId);
});

final cartIsProcessingProvider = StateProvider((ref) => false);
