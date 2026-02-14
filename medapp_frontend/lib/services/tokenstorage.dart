import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage{
  
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  static const _tokenKey = 'auth_token';
  static const _roleKey = 'user_role';
  static const _nameKey = 'user_name';


  static Future<void> saveAuth({required String token, required String role, String? name}) async {
    await clearAuth(); 
    
    await Future.wait([
      _storage.write(key: _tokenKey, value: token),
      _storage.write(key: _roleKey, value: role),
      if (name != null) _storage.write(key: _nameKey, value: name),
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

  static Future<String?> getUserId() async {
    try {
      final token = await getToken();
      if (token == null) return null;
      
      // Decode JWT to extract user ID
      final parts = token.split('.');
      if (parts.length != 3) return null;
      
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> payloadMap = json.decode(decoded);
      
      return payloadMap['id'] as String?;
    } catch (e) {
      print('Error extracting user ID from token: $e');
      return null;
    }
  }

  static Future<String?> getUserName() async {
    try {
      return await _storage.read(key: _nameKey);
    } catch (e) {
      print('Error reading name: $e');
      return null;
    }
  }
  
  static Future<void> clearAuth() async {
    await _storage.deleteAll();
    
    // await _storage.read(key: _tokenKey); 
  }
}
