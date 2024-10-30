import '../../infra/model/product_model.dart';

abstract class IHomeStoreDataSourcer {
  Future<List<ProductModel>> fetchByName(String name);
  Future<List<ProductModel>> fetchFavorite();
  Future<List<ProductModel>> fetchAll();
}
