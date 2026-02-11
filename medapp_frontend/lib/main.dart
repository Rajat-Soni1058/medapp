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
import 'package:medapp_frontend/patient/features/chat/chat.dart';
import 'package:medapp_frontend/doctor/providers/doctorprovider.dart';
import 'package:medapp_frontend/patient/features/home.dart';
import 'package:medapp_frontend/patient/features/patientForm/patient_form.dart';
import 'package:medapp_frontend/patient/features/patientHistory/patient_history.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    // Check auth status when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: DoctorsPatientHistory(),
    //authState.isLoading 
    //       ? Scaffold(
    //           body: Center(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: const [
    //                 CircularProgressIndicator(),
    //                 SizedBox(height: 20),
    //                 Text('Loading...', style: TextStyle(fontSize: 16)),
    //               ],
    //             ),
    //           ),
    //         )
    //       : (authState.isAuthenticated 
    //           ? (authState.role == 'doctor' ? DoctorHome() : DoctorsPatientHistory()) 
    //           : const CommonStart()), 
    );
  }
}
