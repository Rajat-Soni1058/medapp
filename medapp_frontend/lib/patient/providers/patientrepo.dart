import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../../services/apiservice.dart';
import '../../services/tokenstorage.dart';
import '../../doctor/providers/consultationmodel.dart';
import '../../models/doctor_model.dart';

class Patientrepo {
  final ApiService pas = ApiService();
  static const String baseUrl = 'https://consultone-six3.onrender.com';

  Future<List<Consultationmodel>> getunresolved() async {
    final token = await TokenStorage.getToken();
    final response = await pas.get('/patient/unresolved', token: token);
    final list = response['unResolveDocs'] ?? [];
    return list.map((e) => Consultationmodel.fromJson(e)).toList();
  }

  Future<List<Consultationmodel>> getresolved() async {
    final token = await TokenStorage.getToken();
    final response = await pas.get('/patient/resolved', token: token);
    final list = response['ResolveDocs'] ?? [];
    return list.map((e) => Consultationmodel.fromJson(e)).toList();
  }

  Future<Consultationmodel> getconsult(String consultId) async {
    final token = await TokenStorage.getToken();

    final response = await pas.get(
      '/patient/showform/$consultId',
      token: token,
    );

    print("SHOWFORM RESPONSE: $response");

    final data = response['full'];

    if (data == null || data is! Map<String, dynamic>) {
      throw Exception("Invalid consultation data received from backend");
    }

    return Consultationmodel.fromJson(data);
  }

  Future<List<DoctorModel>> getDoctorsBySpeciality(String speciality) async {
    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('401: No authentication token found');
      }
      final response = await pas.get('/patient/$speciality', token: token);
      final list = response['Doclist'] as List;
      return list.map((e) => DoctorModel.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains('401') ||
          e.toString().toLowerCase().contains('unauthorized')) {
        throw Exception('401: Session expired or invalid token');
      }
      rethrow;
    }
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('401: No authentication token found');
      }

      // Fetch doctors from all specialities
      final specialities = [
        'Cardiologist',
        'Dermatologist',
        'General Physician',
        'Neurologist',
        'Orthopedist',
      ];
      final allDoctors = <DoctorModel>[];

      for (final speciality in specialities) {
        try {
          final response = await pas.get('/patient/$speciality', token: token);
          final list = response['Doclist'] as List;
          allDoctors.addAll(list.map((e) => DoctorModel.fromJson(e)));
        } catch (e) {
          // Continue fetching other specialities even if one fails
          continue;
        }
      }

      return allDoctors;
    } catch (e) {
      if (e.toString().contains('401') ||
          e.toString().toLowerCase().contains('unauthorized')) {
        throw Exception('401: Session expired or invalid token');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitForm({
    required String doctorId,
    required String fullName,
    required String age,
    required String gender,
    required String contactNo,
    required String problem,
    required String lifeStyle,
    required String type,
    PlatformFile? file, // 🔥 CHANGE HERE
  }) async {
    try {
      final token = await TokenStorage.getToken();
      print("DEBUG: patientrepo.submitForm token= $token");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/patient/form/$doctorId'),
      );

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.fields['full_name'] = fullName;
      request.fields['age'] = age;
      request.fields['gender'] = gender;
      request.fields['contactNo'] = contactNo;
      request.fields['Problem'] = problem;
      request.fields['life_style'] = lifeStyle;
      request.fields['type'] = type;
      print("File param received in repo: $file");
      if (file != null && file.bytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'patientForm',
            file.bytes!,
            filename: file.name,
          ),
        );
      }
      print("Total files attached: ${request.files.length}");

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () => throw Exception('Request timed out'),
      );
      print("Status code: ${streamedResponse.statusCode}");

      final response = await http.Response.fromStream(streamedResponse);
      print("DEBUG: submitForm raw response body: ${response.body}");

      if (response.statusCode >= 400) {
        try {
          final e = jsonDecode(response.body) as Map<String, dynamic>;
          throw Exception(
            e['msg'] ?? e['message'] ?? e['error'] ?? 'Unknown error',
          );
        } catch (_) {
          throw Exception('${response.statusCode} ${response.body}');
        }
      }

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final res = Map<String, dynamic>.from(decoded);
        if (res['msg'] == null && res.containsKey('consultation')) {
          res['msg'] = res['consultation'];
        }
        return res;
      }

      return {'msg': 'Unexpected response format from server', 'data': decoded};
    } catch (e) {
      throw Exception('Failed to submit form: $e');
    }
  }

  Future<String> getEmergencyMaskedNumber(String consultId) async {
    final token = await TokenStorage.getToken();
    final response = await pas.get(
      '/patient/emergency/masked/$consultId',
      token: token,
    );
    return response['maskedNumber'] ?? '';
  }

  //create order
  Future<Map<String, dynamic>> createOrder(int amount) async {
    final response = await http.post(
      Uri.parse("$baseUrl/payment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"fees": amount}),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RAW BODY: ${response.body}");

    return jsonDecode(response.body);
  }

  //verify payment
  Future<Map<String, dynamic>> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/payment/verify"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "rzO_ID": orderId,
        "rzP_ID": paymentId,
        "rzSign": signature,
      }),
    );

    return jsonDecode(response.body);
  }
}
