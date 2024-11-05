import 'package:loja/infra/model/product_model.dart';

sealed class HomeStoreState {}

class HomeStoreStateLoading extends HomeStoreState {}

class HomeStoreStateInitial extends HomeStoreState {
  final List<ProductModel> products;

  HomeStoreStateInitial({required this.products});
}

class HomeStoreStateEmpty extends HomeStoreState {}

class HomeStoreStateSearchSuccess extends HomeStoreState {
  final List<ProductModel> products;

  HomeStoreStateSearchSuccess(this.products);
}
