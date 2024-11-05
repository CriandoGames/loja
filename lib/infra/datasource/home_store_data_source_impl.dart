import 'package:loja/core/shared/fake_store.dart';
import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/services/http_service.dart';
import 'package:loja/core/shared/http_response.dart';

class HomeStoreDataSourceImpl implements IHomeStoreDataSource {
  late final IHttpService _httpService;

  HomeStoreDataSourceImpl({required httpService}) {
    _httpService = httpService;

    _httpService.setBaseUrl(FakeStoreApiEndpoint.storeApi);
  }

  @override
  Future<HttpResponse> fetchAll() async => await _httpService.get('/products');
}
