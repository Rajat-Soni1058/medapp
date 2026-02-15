import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'https://consultone-six3.onrender.com';
  static const Duration timeout = Duration(seconds: 60);
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
          throw Exception(e['msg'] ?? e['message'] ?? e['error'] ?? 'Unknown error');
          
        }
        catch(_){
          throw Exception('${response.statusCode} ${response.body}');}
        }
      
      return jsonDecode(response.body) as Map<String,dynamic>;
    } catch (e) {
      throw Exception('Failed to post: $e');
    }
  }
  Future<Map<String,dynamic>> get(String endpoint, {String ?token}) async {
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
        throw Exception(e['msg'] ?? e['message'] ?? e['error'] ?? 'Unknown error');
        
      }
      catch(_){
        throw Exception('${response.statusCode} ${response.body}');}
      }
    
    return jsonDecode(response.body) as Map<String,dynamic>;
  } catch (e) {
    throw Exception('Failed to get: $e');
  }
}


//for exotel
Future<String?> getMaskedNumber(String consultId,{String? token}) async{
  try{
    final data = await get('/patient/emergency/masked/$consultId',token: token);
    return data['maskedNumber'];
  }catch(e){
    print("Error fetching masked number: $e");
    return null;
  }
}
}