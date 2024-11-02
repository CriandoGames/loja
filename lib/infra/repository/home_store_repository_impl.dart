import 'dart:convert';

import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:loja/infra/model/product_model.dart';
import 'package:loja/infra/repository/local_keys/local_keys.dart';

class HomeStoreRepositoryImpl implements IHomeStoreRepository {
  late final IHomeStoreDataSource _dataSource;
  late final ISharedPreferencesService _sharedPreferences;

  HomeStoreRepositoryImpl(
      {required IHomeStoreDataSource dataSource,
      required ISharedPreferencesService sharedPreferences}) {
    _dataSource = dataSource;
    _sharedPreferences = sharedPreferences;
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

  @override
  Future<List<num>> getLocalFavoriteIds() async {
    final savedFavoritesJson =
        await _sharedPreferences.getData<String>(LocalKeys.favorite.name);
    if (savedFavoritesJson != null) {
      final List<dynamic> decodedList = jsonDecode(savedFavoritesJson);

      return decodedList.map((id) => id as num).toList();
    }

    return [];
  }

  @override
  Future<void> saveLocalFavoriteIds(List<num> ids) async {
    final jsonString = jsonEncode(ids);
    await _sharedPreferences.saveData<String>(
      LocalKeys.favorite.name,
      jsonString,
    );
  }

  @override
  Future<List<ProductModel>> getLocalChosenFavorite() async {
    final json = await _sharedPreferences.getData<String>(
      LocalKeys.products.name,
    );
    if (json != null) {
      final decodedJson = jsonDecode(json) as List;
      return decodedJson.map((json) => ProductModel.fromJson(json)).toList();
    }

    return [];
  }

  @override
  Future<void> saveLocalChosenFavorite(List<ProductModel> products) async {
    final jsonString = jsonEncode(products.map((p) => p.toJson()).toList());
    await _sharedPreferences.saveData<String>(
      LocalKeys.products.name,
      jsonString,
    );
  }
}
