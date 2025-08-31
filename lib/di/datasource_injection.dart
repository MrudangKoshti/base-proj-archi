import 'package:base_project/data/datasource/remote/auth_remote_datasource.dart';
import 'package:base_project/data/datasource_impl/remote/auth_remote_datasource.dart';

import 'locator.dart';

void initDataSource() {
  locator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(httpClient: locator()),
  );
}
