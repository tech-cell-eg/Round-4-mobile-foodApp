import 'package:dio/dio.dart';

import '../cache/cache_data.dart';
import 'api_response.dart';
import 'end_points.dart';

class ApiHelper {
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    _instance.initDio();
    return _instance;
  }

  ApiHelper._init();
  Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json', // Add default content-type
      },
    ),
  );

  void initDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("--- Headers : ${options.headers.toString()}");
          print("--- endpoint : ${options.path.toString()}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("--- Response : ${response.data.toString()}");
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print("--- Error : ${error.response?.data.toString()}");

          // Handle HTML responses
          if (error.response?.data is String &&
              (error.response?.data as String).contains('<!DOCTYPE html>')) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'Endpoint not found (404)',
                response: Response(
                  requestOptions: error.requestOptions,
                  statusCode: 404,
                  statusMessage: 'Endpoint not found',
                ),
              ),
            );
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = false, // Changed default to false
    bool isProtected = false,
    bool sendRefreshToken = false,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
            'Content-Type':
                isFormData ? 'multipart/form-data' : 'application/json',
          },
        ),
      );
      return _parseResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  ApiResponse _parseResponse(Response response) {
    // Handle HTML responses
    if (response.data is String &&
        (response.data as String).contains('<!DOCTYPE html>')) {
      return ApiResponse(
        status: false,
        statusCode: response.statusCode ?? 404,
        message: 'Endpoint not found',
      );
    }

    // Original response parsing
    return ApiResponse.fromResponse(response);
  }

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.get(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
          },
        ),
      ),
    );
  }

  ApiResponse _handleDioError(DioException error) {
    // Handle HTML responses
    if (error.response?.data is String &&
        (error.response?.data as String).contains('<!DOCTYPE html>')) {
      return ApiResponse(
        status: false,
        statusCode: error.response?.statusCode ?? 404,
        message: 'Endpoint not found',
      );
    }

    // Original error handling
    return ApiResponse.fromError(error);
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
          },
        ),
      ),
    );
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.delete(
        endPoint,
        options: Options(
          headers: {
            if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
          },
        ),
      ),
    );
  }
}
