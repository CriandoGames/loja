import '../../core/shared/http_response.dart';

abstract class IHttpService {
  Future<HttpResponse> get(String url,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters});

  Future<HttpResponse> post(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters});

  Future<HttpResponse> put(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters});

  Future<HttpResponse> delete(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters});

  Future<HttpResponse> patch(String url,
      {dynamic body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters});

  IHttpService get instance;

  void setAuthorizationToken(String token);
  void setBaseUrl(String url);
}
