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
      print('Login attempt: $endpoint');
      final response = await _apiService.post(endpoint, {
        'email': email,
        'password': password,
      });
      //print('Login response: $response');

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
      print('Login error: $e');
      return e.toString().replaceAll('Exception: ', '').replaceAll('Failed to post: ', '');
    }
  }

  Future<String?> signUp(
      {required Map<String, dynamic> data, required bool isDoctor}) async {
    try {
      final endpoint = isDoctor ? '/doctor/signup' : '/patient/signup';
      print('Signup attempt: $endpoint with data: $data');
      final response = await _apiService.post(endpoint, data);
      print('Signup response: $response');

      if (isDoctor) {
     
        if (response.containsKey('msg') && 
            (response['msg'].toString().toLowerCase().contains('success') ||
             response['msg'].toString().toLowerCase().contains('signed up'))) {
          return null; // Success
        } else if (response.containsKey('error')) {
          return response['error'].toString();
        } else if (response.containsKey('msg')) {
          return response['msg'].toString();
        }
        return 'Signup failed';
      } else {
        
        if (response.containsKey('token')) {
          await TokenStorage.saveAuth(token: response['token'], role: 'patient');
          return null;
        } else if (response.containsKey('error')) {
          return response['error'].toString();
        } else if (response.containsKey('msg')) {
          return response['msg'].toString();
        }
        return 'Signup failed';
      }
    } catch (e) {
      print('Signup error: $e');
      return e.toString().replaceAll('Exception: ', '').replaceAll('Failed to post: ', '');
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearAuth();
  }
}
