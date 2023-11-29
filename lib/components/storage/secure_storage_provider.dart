import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/storage/secure_storage/lifestyle_secure_storage.dart';

final secureStorageProvider = Provider((ref) => LifestyleSecureStorage());
