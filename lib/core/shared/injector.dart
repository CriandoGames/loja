import 'package:get_it/get_it.dart';
import 'package:loja/domain/services/http_service.dart';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:loja/features/home_store/home_store_binding.dart';
import 'package:loja/infra/services/shared_preferences_service_impl.dart';
import '../../infra/services/dio_connect_service.dart';

final injector = GetIt.instance;

void setupInjector() {
  injector.registerFactory<IHttpService>(DioConnectService.new);
  injector.registerLazySingleton<ISharedPreferencesService>(
      SharedPreferencesService.new);
  setupHomeStoreBinding();
}
