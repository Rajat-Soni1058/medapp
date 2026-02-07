import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage{
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _roleKey = 'user_role';


  static Future<void> saveAuth({required String token, required String role}) async {
    await clearAuth(); 
    
    await Future.wait([
      _storage.write(key: _tokenKey, value: token),
      _storage.write(key: _roleKey, value: role),
    ]);
  }
  
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<String?> getUserRole() async {
    return await _storage.read(key: _roleKey);
  }
  
  static Future<void> clearAuth() async {
    await _storage.deleteAll();
    
    // await _storage.read(key: _tokenKey); 
  }
}
