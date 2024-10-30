import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreRepositoryImpl implements IHomeStoreRepository {
  late final IHomeStoreDataSource _dataSource;

  HomeStoreRepositoryImpl({required IHomeStoreDataSource dataSource}) {
    _dataSource = dataSource;
  }

  @override
  Future<List<ProductModel>> fetchFavorite() {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchByName(String name) async {
    final products = await fetchAll();

    return products
        .where((product) =>
            product.name.toUpperCase().contains(name.toUpperCase()))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchAll() async {
    final result = await _dataSource.fetchAll();

    final List<ProductModel> products = [];

    if (result.isSuccess) {
      return (result.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    }

    return products;
  }
}
