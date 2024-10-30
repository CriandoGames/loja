import 'package:loja/domain/shared/http_response.dart';

abstract class IHomeStoreDataSource {
  Future<HttpResponse> fetchAll();
}
