import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medapp_frontend/doctor/features/home.dart';
import 'package:medapp_frontend/doctor/features/history.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: DoctorsPatientHistory(),
    );
  }
}
