import 'package:http/http.dart';
import 'package:medapp_frontend/services/apiservice.dart';
import 'package:medapp_frontend/services/tokenstorage.dart';


//fetching the normal & emergency & history List

class DoctorService {
  final ApiService _api = ApiService();

  Future<List<dynamic>> getNormalCases()async{
    final token = await TokenStorage.getToken();
    print("Token is: $token");
    final response = await _api.get("/doctor/cases/normal",token: token);
    
    print("Response type: ${response.runtimeType}");
    return response as List<dynamic>;
  }

  Future<List<dynamic>> getEmergencyCases() async{
    final token = await TokenStorage.getToken();
    print("Token is: $token");
    final response = await _api.get("/doctor/cases/emergency",token: token);
    print("Response type: ${response.runtimeType}");
    
    return response as List<dynamic>;
  }

  Future<List<dynamic>> getHistory() async {
    final token  = await TokenStorage.getToken();
    print("Token is: $token");
    final response = await _api.get("/doctor/history",token: token);
    print("Response type: ${response.runtimeType}");
    
    return response as List<dynamic>;
  }
  }