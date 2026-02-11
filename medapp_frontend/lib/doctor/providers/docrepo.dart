import 'doc_auth_state.dart';
import '../providers/consultationmodel.dart';
import '../../services/apiservice.dart';
import '../../services/tokenstorage.dart';

class DocRepo{
  final ApiService das = ApiService();
  Future<List<Consultationmodel>> getnormal() async{
    final token = await TokenStorage.getToken();
    final response = await das.get('/doctor/cases/normal' , token: token);
    return (response as List).map((e) => Consultationmodel.fromJson(e)).toList();
  }
  Future<List<Consultationmodel>> getemergency() async {
    final token = await TokenStorage.getToken();
    final response= await das.get('/doctor/cases/emergency', token: token) ;
    return (response as List).map((e)=>Consultationmodel.fromJson(e)).toList();
  }
  Future<List<Consultationmodel>> gethistory()async {
    final token = await TokenStorage.getToken();
    final response  = await das.get('/doctor/history', token: token);
    return (response as List).map((e)=>Consultationmodel.fromJson(e)).toList();
  }
  Future<Consultationmodel> getconsult(String consultId) async {
    final token=await TokenStorage.getToken();
    final response=await das.get('/doctor/showform/$consultId', token: token);
    return Consultationmodel.fromJson(response);
  }

  }