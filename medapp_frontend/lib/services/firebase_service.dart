import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'tokenstorage.dart';
import 'apiservice.dart';
class FirebaseService {
  static Future<void> initialize() async {
    try{
      await Firebase.initializeApp();
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      
      // Note: Message listeners are now handled in DoctorHome and PatientHome
      // so they have access to BuildContext for showing dialogs
      print("firebase chalu");

    }  catch(e){
        print("Error initializing Firebase: $e");
      }
  }
  
  static Future<String?> getFCMtoken() async {
    try {
      final token=await FirebaseMessaging.instance.getToken();
      print("FCM Token: $token");
      return token;
    }
    catch(e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }
  static Future<void> saveFCMTokentobackend() async {
    final fcmtoken =await getFCMtoken();
      final userToken = await TokenStorage.getToken();
    final role = await TokenStorage.getUserRole();
    if(fcmtoken!=null && userToken!=null && role!=null  ) {
      try{
        final endpoint =role== 'doctor' ? 'doctor/fcm' : 'patient/fcm';
        final apiservice = ApiService();
        await apiservice.post(endpoint, {'fcmToken': fcmtoken}, token: userToken);
      }
      catch(e){
        print("Error saving FCM token to backend: $e");
      }
    }
  }
}