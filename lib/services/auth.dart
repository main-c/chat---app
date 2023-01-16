import 'package:chat_app/services/instance.dart';
import 'package:dio/dio.dart';

class AuthService {
  final dio = Dio();
  final String base_url;
  dynamic errors;
  String? key;

  AuthService(String base_url, {this.key}) : base_url = base_url {
    dio.options.baseUrl = this.base_url;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }
  get last_errors => errors;

  Future<bool> register(String email, String login, String password,
      String confirmPassword) async {
    try {
      final response = await dio.post('/register/', data: {
        'email': email,
        'login': login,
        'password': password,
        'confirm_password': confirmPassword,
      });
      if (response.statusCode == 201) {
        print(response.data);
        return true;
      } else {
        errors = response.data;
        print("ERRORS: $errors");
        return false;
      }
    } on DioError catch (e) {
      errors = e.error;
      print("ERRORS: $errors");
      return false;
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

  Future<String?> login(String username, String password) async {
    try {
      final response = await dio
          .post('/login/', data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        key = response.data['key'];
        await Request.storage.write(key: 'auth_key', value: key);
        return response.data['key'];
      } else {
        errors = response.data['errors'];

        return null;
      }
    } on DioError catch (e) {
      errors = e.response?.data['errors'];
      return null;
    }
  }
}
