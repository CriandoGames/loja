import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loja/core/shared/is_connection.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreController extends ValueNotifier<HomeStoreState> {
  late final IHomeStoreRepository _repository;

  HomeStoreController({
    required IHomeStoreRepository repository,
  }) : super(HomeStoreStateEmpty()) {
    _repository = repository;
  }

  Future<void> initialize() async {
    Future.wait([fetchProducts(), fetchFavorites()]);
  }

  List<ProductModel> _allProducts = [];
  List<ProductModel> filteredProducts = [];

  bool isEmptyError() => _allProducts.isEmpty;

  List<num> favoriteIds = [];

  Future<void> fetchFavorites() async {
    favoriteIds = await _repository.getLocalFavoriteIds();
  }

  Future<void> toggleFavorite(num productId) async {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
    await _saveLocalFavoritesIds();
  }

  bool isFavorite(num productId) {
    return favoriteIds.contains(productId);
  }

  bool isConnected() => IsConnection().isConnected;

  Future<void> _saveLocalFavoritesIds() async {
    await _repository.saveLocalFavoriteIds(favoriteIds);
  }

  void searchProductByName(String name) async {
    value = HomeStoreStateLoading();

    final result = await _repository.fetchByName(name);

    if (result.isEmpty) {
      value = HomeStoreStateEmpty();
    } else {
      value = HomeStoreStateSeachSuccess(result);
    }
  }

  Future<void> fetchProducts() async {
    value = HomeStoreStateLoading();

    final result = await _repository.fetchAll();

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
