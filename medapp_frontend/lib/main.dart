import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/auth/common_start.dart';
import 'package:medapp_frontend/auth/login.dart';
import 'package:medapp_frontend/auth/patient_signUp.dart';
import 'package:medapp_frontend/doctor/features/home.dart';
import 'package:medapp_frontend/doctor/features/history.dart';
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
    ref.read(authProvider.notifier).checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: authState.isLoading 
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : (authState.isAuthenticated 
              ? (authState.role == 'doctor' ? DoctorHome() : DoctorHome()) 
              : const CommonStart()), 
              // CommonStart is better root than Login usually as it asks "Doc or Patient"
    );
  }
}
