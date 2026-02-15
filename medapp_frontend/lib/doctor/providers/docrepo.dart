import 'doc_auth_state.dart';
import '../providers/consultationmodel.dart';
import '../../services/apiservice.dart';
import '../../services/tokenstorage.dart';

class DocRepo{
  final ApiService das = ApiService();
  Future<List<Consultationmodel>> getnormal() async{
    final token = await TokenStorage.getToken();
    final response = await das.get('/doctor/cases/normal' , token: token);
    print('NORMAL RESPONSE: $response');
    
    // The backend returns a List directly, not wrapped in a Map
    if (response is List) {
      return response.cast<Map<String, dynamic>>().map((e) => Consultationmodel.fromJson(e)).toList();
    }
    return [];
  }
  Future<List<Consultationmodel>> getemergency() async {
    final token = await TokenStorage.getToken();
    final response = await das.get('/doctor/cases/emergency', token: token);
    print('EMERGENCY RESPONSE: $response');
    
    // The backend returns a List directly, not wrapped in a Map
    if (response is List) {
      return response.cast<Map<String, dynamic>>().map((e) => Consultationmodel.fromJson(e)).toList();
    }
    return [];
  }
  Future<List<Consultationmodel>> gethistory() async {
    final token = await TokenStorage.getToken();
    final response = await das.get('/doctor/history', token: token);
    print('HISTORY RESPONSE: $response');
    
    // The backend returns a List directly, not wrapped in a Map
    if (response is List) {
      return response.cast<Map<String, dynamic>>().map((e) => Consultationmodel.fromJson(e)).toList();
    }
    return [];
  }
  Future<Consultationmodel> getconsult(String consultId) async {
    final token=await TokenStorage.getToken();
    final response=await das.get('/doctor/showform/$consultId', token: token);
    return Consultationmodel.fromJson(response);
  }

  }