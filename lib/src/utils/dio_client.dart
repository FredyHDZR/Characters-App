
import 'package:dio/dio.dart';
import 'package:flutter_character_app/src/utils/constants.dart';

class DioClient {
  static DioClient? _instance;

  late final Dio _dio;

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: apiFuturama,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
    ));
  }

  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
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
