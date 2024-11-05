class HttpResponse {
  final dynamic data;
  final int statusCode;
  final String? error;

  HttpResponse({
    required this.data,
    required this.statusCode,
    this.error,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}
