import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/domain/services/http_service.dart';
import 'package:loja/core/shared/injector.dart';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:loja/infra/datasource/home_store_data_source_impl.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/infra/repository/home_store_repository_impl.dart';

void setupHomeStoreBinding() {
  injector.registerFactory<IHomeStoreDataSource>(
      () => HomeStoreDataSourceImpl(httpService: injector.get<IHttpService>()));
  injector.registerFactory<IHomeStoreRepository>(() => HomeStoreRepositoryImpl(
      sharedPreferences: injector.get<ISharedPreferencesService>(),
      dataSource: injector.get<IHomeStoreDataSource>()));

  injector.registerSingleton<HomeStoreController>(HomeStoreController(
    repository: injector.get<IHomeStoreRepository>(),
  ));
}
