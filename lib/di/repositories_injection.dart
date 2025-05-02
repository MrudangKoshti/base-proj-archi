import '../data/http_helper/repository_helper.dart';
import '../data/repositories/auth_repositories_impl.dart';
import '../domain/repositories/auth_repository.dart';
import 'locator.dart';

void initRepositories() {
  locator
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoriesImpl(
        repositoryHelper: locator(),
        remoteDatasource: locator(),
      ),
    )
    ..registerLazySingleton<RepositoryHelper<dynamic>>(
      () => RepositoryHelperImpl<dynamic>(locator()),
    );
}
