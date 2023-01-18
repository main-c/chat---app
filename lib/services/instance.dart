import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/jioni_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Request {
  static late FlutterSecureStorage storage;
  static late String _base_url;
  static late AuthService auth_service;
  static late ApiClient client;
  static late String? auth_key;
  // static AbstractPrivateProfile? profile;

  static Future init(String base_url) async {
    storage = const FlutterSecureStorage();
    _base_url = base_url;
    auth_service = AuthService(base_url);
    String? auth_key = await storage.read(key: 'access_token');
    if (auth_key != null) {
      client = ApiClient(base_url: _base_url, key: auth_key);
    } else {
      client = ApiClient(base_url: base_url, key: '');
    }
  }

  static void createClient(String key) {
    auth_key = key;
    client.key = key;
  }

  static Future<bool> isAuthenticated() async {
    final auth_key = await storage.read(key: 'access_token');
    return (auth_key != null && auth_key.isNotEmpty) ? true : false;
  }
}
