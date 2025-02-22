



import '../data/datasource/remote/auth_remote_datasource.dart';
import '../data/datasource_impl/remote/auth_remote_datasource.dart';
import 'locator.dart';

void initDataSource() {
  locator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(httpHelper: locator()),
  );
}
