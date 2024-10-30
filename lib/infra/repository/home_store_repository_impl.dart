import 'package:loja/domain/data/home_store_data_sourcer.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreRepositoryImpl implements IHomeStoreRepository {
  late final IHomeStoreDataSourcer _homeStoreDataSourcer;

  HomeStoreRepositoryImpl(
      {required IHomeStoreDataSourcer homeStoreDataSourcer}) {
    _homeStoreDataSourcer = homeStoreDataSourcer;
  }

  @override
  Future<List<ProductModel>> fetchFavorite() {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchByName(String name) {
    return _homeStoreDataSourcer.fetchByName(name);
  }

  @override
  Future<List<ProductModel>> fetchAll() => _homeStoreDataSourcer.fetchAll();
}
