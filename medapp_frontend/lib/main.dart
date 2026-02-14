import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/auth/common_start.dart';
import 'package:medapp_frontend/auth/doctorSignUp/doctor_sign_up_1.dart';
import 'package:medapp_frontend/auth/doctorSignUp/doctor_sign_up_2.dart';
import 'package:medapp_frontend/auth/login.dart';
import 'package:medapp_frontend/auth/patient_signUp.dart';
import 'package:medapp_frontend/doctor/features/home.dart';
import 'package:medapp_frontend/doctor/features/history.dart';
import 'package:medapp_frontend/models/doctor_model.dart';
import 'package:medapp_frontend/patient/features/chat/chat.dart';
import 'package:medapp_frontend/doctor/providers/consultationmodel.dart';
import 'package:medapp_frontend/doctor/providers/doctorprovider.dart';
import 'package:medapp_frontend/patient/features/home.dart';
import 'package:medapp_frontend/patient/features/patientForm/patient_form.dart';
import 'package:medapp_frontend/patient/features/patientHistory/patient_history.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';
import 'package:medapp_frontend/services/firebase_service.dart';
import 'package:medapp_frontend/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Background message received: ${message.notification?.title}");

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  await FirebaseService.initialize();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    )
  );
  
  runApp(const ProviderScope(child: MainApp()));
}
class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authProvider.notifier).checkAuthStatus();
      final authState = ref.read(authProvider);
      if (authState.isAuthenticated) {
        await FirebaseService.saveFCMTokentobackend();
      }
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null && mounted) {
        _handleNotificationTap(initialMessage);
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    if (message.data['type'] == 'video_call') {
      final callId = message.data['callId'] ?? message.data['consultationId'];
      final patientName = message.data['patientName'] ?? 'Patient';
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          print('App launched from notification: callId=$callId, patient=$patientName');
         
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: authState.isLoading 
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading...', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              )
            : (authState.isAuthenticated 
                ? (authState.role == 'doctor' ? DoctorHome() : PatientHome()) 
                : const CommonStart()), 
    );
  }
}
