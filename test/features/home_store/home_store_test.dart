import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:loja/features/home_store/home_store.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';
import 'package:loja/infra/model/product_model.dart';
import 'package:loja/infra/model/rate_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeStoreController extends Mock implements HomeStoreController {}

void main() {
  late HomeStoreController controller;

  void setupDependencyInjection() {
    if (!GetIt.I.isRegistered<HomeStoreController>()) {
      GetIt.I.registerSingleton<HomeStoreController>(MockHomeStoreController());
    }
  }

  setUpAll(() {
    registerFallbackValue(ProductModel(
      id: 0,
      name: 'dummy',
      description: 'dummy',
      price: 0,
      category: 'dummy',
      imageUrl: 'dummy.png',
      rating: RateModel(rate: 0, reviewCount: 0),
    ));
  });

  setUp(() {
    setupDependencyInjection();
    controller = GetIt.instance<HomeStoreController>();

    when(() => controller.allProducts).thenAnswer((_) => []);
    when(() => controller.favorite).thenAnswer((_) => ValueNotifier([
          const ProductModel(
            category: 'category',
            description: 'description',
            id: 1,
            imageUrl: 'imageUrl.png',
            name: 'name',
            price: 50,
            rating: RateModel(
              rate: 3.5,
              reviewCount: 1250,
            ),
          )
        ]));
    when(() => controller.filteredProducts).thenAnswer((_) => []);
    when(() => controller.value).thenAnswer((_) => HomeStoreStateEmpty());
    when(() => controller.fetchFavorites())
        .thenAnswer((_) async => Future.value());
    when(() => controller.fetchProducts())
        .thenAnswer((_) async => Future.value());
    when(() => controller.initialize()).thenAnswer((_) async => Future.value());
    when(() => controller.isEmptyError()).thenAnswer((_) => false);
    when(() => controller.isFavorite(any())).thenReturn(false);
    when(() => controller.isFavorite(any())).thenReturn(false);
    when(() => controller.isFavorite(any())).thenReturn(false);
    when(() => controller.isFavorite(any())).thenReturn(false);
    when(() => controller.isConnected()).thenAnswer((_) => ValueNotifier(true));
    when(() => controller.filterByName('productName')).thenAnswer((_) => () {});
    when(() => controller.searchProductByName('productName'))
        .thenAnswer((_) => () {});
  });

  group('widgets: ', () {
    testWidgets('success page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeStore()));

      expect(
        find.byType(HomeStore),
        findsOneWidget,
      );
    });

    testWidgets('displays loading indicator when state is loading',
        (tester) async {
      when(() => controller.value).thenReturn(HomeStoreStateLoading());

      await tester.pumpWidget(const MaterialApp(home: HomeStore()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays empty state when state is empty', (tester) async {
      when(() => controller.value).thenReturn(HomeStoreStateEmpty());

      await tester.pumpWidget(const MaterialApp(home: HomeStore()));

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
