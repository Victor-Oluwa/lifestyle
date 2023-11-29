import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/core/connectivity/service/connectivity_service.dart';

final connectivityServiceProvider = Provider((ref) => ConnectivityService());
final isConnected = StateProvider((ref) => true);
