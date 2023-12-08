import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../function/order_tracking_function.dart';

final orderTrackingFunctionProvider =
    Provider((ref) => OrderTrackingFunction(ref: ref));
