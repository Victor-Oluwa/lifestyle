import 'dart:async';

import 'package:flutter/material.dart';

class Bouncer {
  Timer? _timer;

  void run(
    VoidCallback action, {
    Duration delay = const Duration(seconds: 1),
  }) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
