import 'package:flutter/material.dart';
import 'package:medapp_frontend/doctor/features/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorHome(),
    );
  }
}
