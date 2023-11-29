import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/home_services.dart';

final homeServiceProvider =
    Provider.autoDispose((ref) => HomeServices(ref: ref));
