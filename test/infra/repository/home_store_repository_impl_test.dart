import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loja/core/shared/http_response.dart';
import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:loja/infra/model/product_model.dart';
import 'package:loja/infra/model/rate_model.dart';
import 'package:loja/infra/repository/home_store_repository_impl.dart';
import 'package:loja/infra/repository/local_keys/local_keys.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeStoreDataSource extends Mock implements IHomeStoreDataSource {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  late IHomeStoreDataSource dataSource;
  late IHomeStoreRepository repository;
  late ISharedPreferencesService sharedPreferences;

  setUp(() {
    dataSource = MockHomeStoreDataSource();
    sharedPreferences = MockSharedPreferencesService();
    repository = HomeStoreRepositoryImpl(
      sharedPreferences: sharedPreferences,
      dataSource: dataSource,
    );
  });

  group('repository: ', () {
    test('must return list product model when it is success', () async {
      const tStatusCode = 200;
      final tData = [
        {
          'id': 1,
          'title': 'title the product',
          'description': 'description the product',
          'price': 59.9,
          'category': 'category the product',
          'image': 'image1.png',
          'rating': {
            'count': 50,
            'rate': 4.9,
          },
        },
        {
          'id': 2,
          'title': 'title2 the product',
          'description': 'description2 the product',
          'price': 15.5,
          'category': 'category2 the product',
          'image': 'image2.png',
          'rating': {
            'count': 99,
            'rate': 3.7,
          },
        }
      ];

      const tModel = [
        ProductModel(
            id: 1,
            name: 'title the product',
            description: 'description the product',
            price: 59.9,
            category: 'category the product',
            imageUrl: 'image1.png',
            rating: RateModel(reviewCount: 50, rate: 4.9)),
        ProductModel(
            id: 2,
            name: 'title2 the product',
            description: 'description2 the product',
            price: 15.5,
            category: 'category2 the product',
            imageUrl: 'image2.png',
            rating: RateModel(reviewCount: 99, rate: 3.7)),
      ];

      when(() => dataSource.fetchAll()).thenAnswer(
        (_) async => HttpResponse(data: tData, statusCode: tStatusCode),
      );

      final result = await repository.fetchAll();

      expect(result, tModel);
    });

    test('must return list empty when it is failure', () async {
      const tStatusCode = 404;
      final tData = {'message_error': 'unknown error'};

      final tModel = <ProductModel>[];

      when(() => dataSource.fetchAll()).thenAnswer(
        (_) async => HttpResponse(data: tData, statusCode: tStatusCode),
      );

      final result = await repository.fetchAll();

      expect(result, tModel);
    });
  });

  group('local repository', () {
    test('must return list of num in local shared preferences', () async {
      final tNumJson = jsonEncode([1, 3, 5]);
      when(() => sharedPreferences.getData<String>(
            LocalKeys.favorite.name,
          )).thenAnswer((_) async => tNumJson);

      final result = await repository.getLocalFavoriteIds();
      expect(result, jsonDecode(tNumJson));
    });

    test('must return list of products in local shared preferences', () async {
      const tModel = [
        ProductModel(
            id: 1,
            name: 'title the product',
            description: 'description the product',
            price: 59.9,
            category: 'category the product',
            imageUrl: 'image1.png',
            rating: RateModel(reviewCount: 50, rate: 4.9)),
        ProductModel(
          id: 2,
          name: 'title2 the product',
          description: 'description2 the product',
          price: 15.5,
          category: 'category2 the product',
          imageUrl: 'image2.png',
          rating: RateModel(reviewCount: 99, rate: 3.7),
        ),
      ];

      final tModelJson = jsonEncode(tModel.map((e) => e.toJson()).toList());

      when(() => sharedPreferences.getData<String>(
            LocalKeys.products.name,
          )).thenAnswer((_) async => tModelJson);

      final decodedJson = jsonDecode(tModelJson) as List;

      final tModelList =
          decodedJson.map((json) => ProductModel.fromJson(json)).toList();

      final result = await repository.getLocalChosenFavorite();

      expect(result, tModelList);
    });
  });
}
