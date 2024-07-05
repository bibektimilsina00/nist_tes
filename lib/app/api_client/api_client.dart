import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/api_routes.dart';

class ApiClient {
  static BaseOptions defaultOptions = BaseOptions(
    baseUrl: ApiRoutes.baseUrl,
  );

  Dio dio;

  ApiClient({BaseOptions? options}) : dio = Dio(options ?? defaultOptions) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.baseUrl = ApiRoutes.baseUrl;
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException exception, handler) {
        return handler.next(exception);
      },
    ));
  }

  Future<Options> createOptions() async {
    String? token = await getToken();
    return Options(
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return dio.delete(
      path,
      data: data,
      options: await createOptions(),
    );
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: await createOptions(),
    );
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Response> post(String path, {Object? data}) async {
    return dio.post(
      path,
      data: data,
      options: await createOptions(),
    );
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return dio.put(path, data: data, options: await createOptions());
  }
}
