import 'package:loja/domain/services/http_service.dart';
import 'package:loja/core/shared/http_response.dart';
import 'package:dio/dio.dart';

class DioConnectService implements IHttpService {
  final Dio _dio = Dio();

  @override
  Future<HttpResponse> delete(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> get(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  @override
  IHttpService get instance => DioConnectService();

  @override
  Future<HttpResponse> patch(String url,
      {body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> post(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> put(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  @override
  void setAuthorizationToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  HttpResponse _handleError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final errorData = error.response?.data ?? 'Erro desconhecido';
    final errorMessage = error.message;

    return HttpResponse(
      data: errorData,
      statusCode: statusCode,
      error: errorMessage,
    );
  }
}
