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
      print('Login response: $response');
      print('Response keys: ${response.keys}');
      print('Response doctorName value: ${response['doctorName']}');

      if (response.containsKey('token')) {
        final doctorName = isDoctor ? response['doctorName'] : null;
        print('Saving auth - Token exists: true, isDoctor: $isDoctor, doctorName: $doctorName');
        
        await TokenStorage.saveAuth(
          token: response['token'],
          role: isDoctor ? 'doctor' : 'patient',
          name: doctorName,
        );
        
        // Verify the name was saved
        final savedName = await TokenStorage.getUserName();
        print('Name saved to storage: $savedName');
        
        return null; // Success
      } else {
        final errorMsg = response['msg'] ?? response['error'] ?? 'Login failed';
        print('Login failed: $errorMsg');
        return errorMsg;
      }
    } catch (e) {
      print('Login error caught: $e');
      final errorMessage = e.toString()
          .replaceAll('Exception: ', '')
          .replaceAll('Failed to post: ', '');
      print('Processed error message: $errorMessage');
      return errorMessage;
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
