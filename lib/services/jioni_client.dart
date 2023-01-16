import 'package:dio/dio.dart';

class ApiClient {
  String key;
  final String base_url;
  final dio = Dio();

  ApiClient({required this.base_url, required this.key}) {
    this.dio.options.baseUrl = base_url;
    this.dio.options.headers = {'Authorization': "Bearer $key"};
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: false,
    ));
  }

  Future<Response<dynamic>> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, String>? files,
      Map<String, String>? raw_files,
      Map<String, String>? params}) async {
    if (files != null) {
      for (String key in files.keys) {
        final String filename = files[key]!.split("/").last;
        data[key] =
            await MultipartFile.fromFile(files[key]!, filename: filename);
      }

      final formData = FormData.fromMap(data);

      return dio.post(endpoint, data: formData, queryParameters: params);
    } else if (raw_files != null) {
      data.addAll(raw_files);
      final formData = FormData.fromMap(data);
      return dio.post(endpoint, data: formData, queryParameters: params);
    } else {
      return dio.post(endpoint, data: data, queryParameters: params);
    }
  }

  Future<Response<dynamic>> get(
      {required String endpoint, required Map<String, String> params}) {
    return dio.get(endpoint, queryParameters: params);
  }

  Future<Response<dynamic>> patch(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, String>? files,
      Map<String, String>? raw_files,
      Map<String, String>? params}) async {
    if (files != null) {
      for (String key in files.keys) {
        final String filename = files[key]!.split("/").last;
        data[key] = await MultipartFile.fromFile(data[key], filename: filename);
      }

      final formData = FormData.fromMap(data);
      return dio.patch(endpoint, data: formData, queryParameters: params);
    } else if (raw_files != null) {
      data.addAll(raw_files);
      final formData = FormData.fromMap(data);
      return dio.patch(endpoint, data: formData, queryParameters: params);
    } else {
      return dio.patch(endpoint, data: data, queryParameters: params);
    }
  }
}
