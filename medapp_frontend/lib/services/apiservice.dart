import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'https://consultone-six3.onrender.com';
  static const Duration timeout = Duration(seconds: 30);
  Future<Map<String,dynamic>> post (String endpoint, Map<String,dynamic> body, {String ?token} ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          "Content-Type": "application/json",
          if(token!=null) "Authorization": "Bearer $token",

        },
        body: jsonEncode(body),
      ).timeout(timeout, onTimeout: () => throw Exception('Request timed out'));

      if(response.statusCode>=400) {
        try{
          final e=jsonDecode(response.body) as Map<String,dynamic>;
          throw Exception('Failed to post: ${e['message'] ?? 'Unknown error'}');
          
        }
        catch(_){
          throw Exception('Failed to post: ${response.statusCode} ${response.body}');}
        }
      
      return jsonDecode(response.body) as Map<String,dynamic>;
    } catch (e) {
      throw Exception('Failed to post: $e');
    }
  }
  Future<dynamic> get(String endpoint, {String ?token}) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        "Content-Type": "application/json",
        if(token!=null) "Authorization": "Bearer $token",
      },
    ).timeout(timeout, onTimeout: () => throw Exception('Request timed out'));

    if(response.statusCode>=400) {
      try{
        final e=jsonDecode(response.body) as Map<String,dynamic>;
        throw Exception('Failed to get: ${e['message'] ?? 'Unknown error'}');
        
      }
      catch(_){
        throw Exception('Failed to get: ${response.statusCode} ${response.body}');}
      }
    
    return jsonDecode(response.body);
  } catch (e) {
    throw Exception('Failed to get: $e');
  }
}
}

