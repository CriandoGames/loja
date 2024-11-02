import 'package:flutter_test/flutter_test.dart';
import 'package:loja/core/shared/http_response.dart';
import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/infra/model/product_model.dart';
import 'package:loja/infra/model/rate_model.dart';
import 'package:loja/infra/repository/home_store_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeStoreDataSource extends Mock implements IHomeStoreDataSource {}

void main() {
  late IHomeStoreDataSource dataSource;
  late IHomeStoreRepository repository;

  setUp(() {
    dataSource = MockHomeStoreDataSource();
    repository = HomeStoreRepositoryImpl(dataSource: dataSource);
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

      final tModel = [
        ProductModel(
            id: 1,
            name: 'title the product',
            description: 'description the product',
            price: 59.9,
            category: 'category the product',
            imageUrl: 'image1.png',
            rating: const RateModel(reviewCount: 50, rate: 4.9)),
        ProductModel(
            id: 2,
            name: 'title2 the product',
            description: 'description2 the product',
            price: 15.5,
            category: 'category2 the product',
            imageUrl: 'image2.png',
            rating: const RateModel(reviewCount: 99, rate: 3.7)),
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
}
