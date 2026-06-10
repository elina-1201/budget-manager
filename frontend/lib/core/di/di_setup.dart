import 'package:get_it/get_it.dart';

import '../config/base_url.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<String>(ApiBaseUrl.get());
}
