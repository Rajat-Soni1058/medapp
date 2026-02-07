import 'package:medapp_frontend/services/apiservice.dart';
import 'package:medapp_frontend/services/tokenstorage.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<String?> login(
      {required String email,
      required String password,
      required bool isDoctor}) async {
    try {
      final endpoint = isDoctor ? '/doctor/signin' : '/patient/login';
      final response = await _apiService.post(endpoint, {
        'email': email,
        'password': password,
      });

      if (response.containsKey('token')) {
        await TokenStorage.saveAuth(
          token: response['token'],
          role: isDoctor ? 'doctor' : 'patient',
        );
        return null; // Success
      } else {
        return response['msg'] ?? response['error'] ?? 'Login failed';
      }
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  Future<String?> signUp(
      {required Map<String, dynamic> data, required bool isDoctor}) async {
    try {
      final endpoint = isDoctor ? '/doctor/signup' : '/patient/signup';
      final response = await _apiService.post(endpoint, data);

    
      if (isDoctor) {
     
        return null; 
      } else {
         if (response.containsKey('token')) {
             await TokenStorage.saveAuth(token: response['token'], role: 'patient');
             return null;
         }
      }
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearAuth();
  }
}
