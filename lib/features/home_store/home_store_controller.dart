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

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  bool isEmptyError() => allProducts.isEmpty;

  ValueNotifier<List<ProductModel>> favorite = ValueNotifier([]);

  Future<void> fetchFavorites() async {
    favorite.value = await _repository.getLocalChosenFavorite();

    favorite.addListener(() {
      notifyListeners();
    });
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (favorite.value.contains(product)) {
      favorite.value.remove(product);
    } else {
      favorite.value.add(product);
    }
    await _saveLocalFavoritesIds();
    notifyListeners();
  }
 
  bool isFavorite(ProductModel product) {
    return favorite.value.contains(product);
  }

  ValueNotifier<bool> isConnected() {
    final connectionService = InternetConnectionService();
    return connectionService.isConnected;
  }

  Future<void> _saveLocalFavoritesIds() async {
    await _repository.saveLocalChosenFavorite(favorite.value);
  }

  void searchProductByName(String name) async {
    value = HomeStoreStateLoading();

    final result = await _repository.fetchByName(name);

    if (result.isEmpty) {
      value = HomeStoreStateEmpty();
    } else {
      value = HomeStoreStateSearchSuccess(result);
    }
  }

  Future<void> fetchProducts() async {
    value = HomeStoreStateLoading();

    final result = await _repository.fetchAll();

    if (result.isEmpty) {
      value = HomeStoreStateEmpty();
    } else {
      filteredProducts = result;
      allProducts = filteredProducts;

      value = HomeStoreStateInitial(products: result);
    }
  }

  void filterByName(String? name) {
    if (name == null || name.isEmpty) {
      filteredProducts = allProducts;
      value = HomeStoreStateInitial(products: allProducts);
      return;
    }

    filteredProducts = allProducts
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
