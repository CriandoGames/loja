import 'package:loja/infra/model/product_model.dart';

abstract class IHomeStoreRepository {
  Future<List<ProductModel>> fetchByName(String name);
  Future<List<ProductModel>> fetchFavorite();
  Future<List<ProductModel>> fetchAll();
}
