import 'package:loja/infra/model/product_model.dart';

abstract class IHomeStoreRepository {
  Future<List<ProductModel>> fetchByName(String name);
  Future<List<ProductModel>> fetchAll();
  Future<List<num>> getLocalFavoriteIds();
  Future<void> saveLocalFavoriteIds(List<num> ids);
  Future<void> saveLocalChosenFavorite(List<ProductModel> products);
  Future<List<ProductModel>> getLocalChosenFavorite();
}
