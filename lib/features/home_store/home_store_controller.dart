import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loja/core/shared/is_connection.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreController extends ValueNotifier<HomeStoreState> {
  late final IHomeStoreRepository _dataSource;
  late final ISharedPreferencesService _sharedPreferencesService;

  HomeStoreController(
      {required IHomeStoreRepository dataSource,
      required ISharedPreferencesService sharedPreferencesService})
      : super(HomeStoreStateEmpty()) {
    _dataSource = dataSource;
    _sharedPreferencesService = sharedPreferencesService;
  }

  List<ProductModel> _allProducts = [];
  List<ProductModel> filteredProducts = [];

  bool isEmptyError() => _allProducts.isEmpty;

  List<num> favoriteIds = [];

  Future<void> loadFavorites() async {
    final savedFavoritesJson =
        await _sharedPreferencesService.getData<String>('favorites');
    if (savedFavoritesJson != null) {
      final List<dynamic> decodedList = jsonDecode(savedFavoritesJson);
      favoriteIds = decodedList.map((id) => id as num).toList();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(num productId) async {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
    await _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(num productId) {
    return favoriteIds.contains(productId);
  }

  bool isConnected() => IsConnection().isConnected;

  Future<void> _saveFavorites() async {
    final jsonString = jsonEncode(favoriteIds);
    await _sharedPreferencesService.saveData<String>('favorites', jsonString);
  }

  void searchProductByName(String name) async {
    value = HomeStoreStateLoading();

    final result = await _dataSource.fetchByName(name);

    if (result.isEmpty) {
      value = HomeStoreStateEmpty();
    } else {
      value = HomeStoreStateSeachSuccess(result);
    }
  }

  Future<void> fetchProducts() async {
    value = HomeStoreStateLoading();

    final result = await _dataSource.fetchAll();

    if (result.isEmpty) {
      value = HomeStoreStateEmpty();
    } else {
      filteredProducts = result;
      _allProducts = filteredProducts;

      value = HomeStoreStateInitial(products: result);
    }
  }

  void filterByCategory(String? name) {
    if (name == null || name.isEmpty) {
      filteredProducts = _allProducts;
      value = HomeStoreStateInitial(products: _allProducts);
      return;
    }

    filteredProducts = _allProducts
        .where((element) =>
            element.name.toUpperCase().contains(name.toUpperCase()))
        .toList();

    if (filteredProducts.isEmpty) {
      value = HomeStoreStateEmpty();
      return;
    }

    value = HomeStoreStateInitial(products: filteredProducts);
  }
}
