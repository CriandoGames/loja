import 'package:flutter_test/flutter_test.dart';
import 'package:loja/core/shared/http_response.dart';
import 'package:loja/domain/data/home_store_data_source.dart';
import 'package:loja/domain/services/http_service.dart';
import 'package:loja/infra/datasource/home_store_data_source_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements IHttpService {}

void main() {
  late IHttpService httpService;
  late IHomeStoreDataSource dataSource;

  setUp(() {
    httpService = MockHttpService();
    dataSource = HomeStoreDataSourceImpl(httpService: httpService);
  });

  group('data_source: ', () {
    const tStatusCode = 200;
    final tData = {
      'id': 1,
      'title': 'title the product',
      'description': 'description the product',
      'price': 59.9,
      'category': 'category the product',
      'image':
          'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
      'rating': {
        'count': 50,
        'rate': 4.9,
      },
    };

    test('must return http response data when status code is 200', () async {
      when(() => httpService.get('/products')).thenAnswer(
        (_) async => HttpResponse(data: tData, statusCode: tStatusCode),
      );

      final result = await dataSource.fetchAll();

      expect(result.data, tData);
      expect(result.statusCode, tStatusCode);
    });
  });
}
