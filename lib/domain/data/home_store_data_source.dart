import 'package:loja/core/shared/http_response.dart';

abstract class IHomeStoreDataSource {
  Future<HttpResponse> fetchAll();
}
