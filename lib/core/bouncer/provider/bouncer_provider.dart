import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/core/bouncer/bouncer.dart';

final bouncerProvider = Provider.autoDispose((ref) {
  ref.keepAlive();
  return Bouncer();
});
