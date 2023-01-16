import 'dart:convert';
import 'dart:io';

import 'package:chat_app/services/instance.dart';
import 'package:dio/dio.dart';

class AuthService {
  final dio = Dio();
  final String base_url;
  dynamic errors;
  String? key;

  AuthService(String base_url, {this.key}) : base_url = base_url {
    dio.options.baseUrl = this.base_url;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }
  get last_errors => errors;

  Future<bool> register(String email, String login, String password,
      String confirmPassword) async {
    try {
      dynamic data = {
        "email": email,
        "login": login,
        "password": password,
        "confirm_password": confirmPassword
      };

      // convert to json
      String jsonData = jsonEncode(data);

      final Response<dynamic> response =
          await dio.post('/register', data: jsonData);

      if (response.statusCode == 201) {
        print(response.data);
        return true;
      } else {
        errors = response.data['detail'];

        return false;
      }
    } on DioError catch (e) {
      errors = e.response?.data['detail'];
      print("ERRORS: $errors");
      return false;
    }
  }

  Future<String?> login(String username, String password) async {
    try {
      var data = {
        "password": password,
        "username": username,
      };
      var formData = FormData.fromMap(data);
      final response = await dio.post('/login',
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (response.statusCode == 200) {
        key = response.data['access_token'];
        await Request.storage.write(key: 'access_token', value: key);
        return key;
      } else {
        errors = response.data;

        return null;
      }
    } on DioError catch (e) {
      errors = e.response?.data["detail"];

      return null;
    }
  }

  Future<bool> activate(String code) async {
    try {
      final response =
          await dio.post('/activate/', data: {'registration_code': code});
      if (response.statusCode == 200) {
        return true;
      } else {
        errors = response.data['errors'];
        return false;
      }
    } on DioError catch (e) {
      errors = e.response?.data['errors'];
      return false;
    }
  }
}
