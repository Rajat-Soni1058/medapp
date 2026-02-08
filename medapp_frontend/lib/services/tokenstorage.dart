import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage{
  
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
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
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      print('Error reading token: $e');
      return null;
    }
  }

  static Future<String?> getUserRole() async {
    try {
      return await _storage.read(key: _roleKey);
    } catch (e) {
      print('Error reading role: $e');
      return null;
    }
  }
  
  static Future<void> clearAuth() async {
    await _storage.deleteAll();
    
    // await _storage.read(key: _tokenKey); 
  }
}
