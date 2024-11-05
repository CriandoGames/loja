import 'package:flutter_test/flutter_test.dart';
import 'package:loja/domain/repositories/home_store_repository.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/infra/model/product_model.dart';
import 'package:loja/infra/model/rate_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeStoreRepository extends Mock implements IHomeStoreRepository {}

void main() {
  late IHomeStoreRepository repository;
  late HomeStoreController sut;
  setUp(() {
    repository = MockHomeStoreRepository();
    sut = HomeStoreController(repository: repository);
  });

  group('controller: ', () {
    const tModel = [
      ProductModel(
        category: 'category1',
        description: 'description1',
        id: 1,
        imageUrl: ' image1.png',
        name: 'name1',
        price: 50,
        rating: RateModel(
          rate: 3.5,
          reviewCount: 1250,
        ),
      ),
      ProductModel(
        category: 'category2',
        description: 'description2',
        id: 2,
        imageUrl: ' image2.png',
        name: 'name2',
        price: 158,
        rating: RateModel(
          rate: 4.9,
          reviewCount: 532,
        ),
      ),
    ];

    test('when called fetchAll then return allProducts list', () async {
      when(() => repository.fetchAll()).thenAnswer((_) async => tModel);
      await sut.fetchProducts();
      expect(sut.allProducts, tModel);
    });

    test('when called fetchByName then return filter products', () async {
      when(() => repository.fetchByName('name1')).thenAnswer(
        (_) async => tModel,
      );

      sut.filterByName('name1');
      sut.filteredProducts = tModel;
      expect(sut.filteredProducts[0].name, tModel[0].name);
    });

    test('when called fetchByName then return empty', () async {
      when(() => repository.fetchByName('unknown')).thenAnswer(
        (_) async => [],
      );

      sut.filterByName('unknown');
      expect(sut.filteredProducts.isEmpty, isTrue);
    });
  });
}
