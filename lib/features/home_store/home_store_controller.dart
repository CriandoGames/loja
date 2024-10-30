import 'package:flutter/material.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';

class HomeStoreController extends ValueNotifier<HomeStoreState> {
  late final IHomeStoreRepository _dataSource;

  HomeStoreController({required IHomeStoreRepository dataSource})
      : super(HomeStoreStateEmpty()) {
    _dataSource = dataSource;
  }

  Future<void> searchProductByName(String name) async {
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
      value = HomeStoreStateError("");
    } else {
      value = HomeStoreStateInitial(products: result);
    }
  }
}
