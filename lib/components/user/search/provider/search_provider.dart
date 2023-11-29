import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/providers/actions/provider_operations.dart';

final queryProvider = StateProvider((ref) => '');
final searchResultProvider =
    FutureProvider.autoDispose.family((ref, String query) async {
  final searchFunction = ref.read(searchFunctionProvider);
  return await searchFunction.fetchSearchedProducts(query: query);
});
