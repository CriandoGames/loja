import 'package:loja/domain/data/home_store_data_sourcer.dart';
import 'package:loja/domain/services/http_service.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreDataSourcerImpl implements IHomeStoreDataSourcer {
  late final IHttpService _httpService;

  HomeStoreDataSourcerImpl({required httpService}) {
    _httpService = httpService;

    _httpService.setBaseUrl('https://fakestoreapi.com');
  }

  @override
  Future<List<ProductModel>> fetchAll() async {
    final response = await _httpService.get('/products');
    final List<ProductModel> products = [];

    if (response.isSuccess) {
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }

      return products;
    }

    return products;
  }

  @override
  Future<List<ProductModel>> fetchByName(String name) async {
    final List<ProductModel> products = await fetchAll();

    return products
        .where((element) =>
            element.name.toUpperCase().contains(name.toUpperCase()))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchFavorite() async {
    throw UnimplementedError();
  }
}
