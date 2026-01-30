
import 'package:dio/dio.dart';
import 'package:flutter_character_app/src/utils/constants.dart';

class DioClient {
  static final Map<String, DioClient> _instances = {};

  late final Dio _dio;
  final String baseUrl;

  DioClient._internal(this.baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
    ));
  }

  static DioClient get instance => getInstance(apiFuturama);

  static DioClient getInstance(String baseUrl) {
    if (!_instances.containsKey(baseUrl)) {
      _instances[baseUrl] = DioClient._internal(baseUrl);
    }
    return _instances[baseUrl]!;
  }

  Dio get dio => _dio;

  Future<Response> httpGet(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters,
          options: Options(
              headers: getHeaders(headers),
              contentType: Headers.jsonContentType));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> httpPost(String path,
      {required Map<String, dynamic> data,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
              headers: getHeaders(headers),
              contentType: Headers.jsonContentType));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, String> getHeaders(Map<String, String>? headers) {
    headers ??= {};
    headers['Accept'] = 'application/json';
    return headers;
  }
}
