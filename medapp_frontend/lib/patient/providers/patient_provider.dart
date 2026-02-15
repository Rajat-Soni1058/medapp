import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/patient/providers/patientrepo.dart';
import 'package:medapp_frontend/doctor/providers/consultationmodel.dart';

//pending provider (cancelled)
final patientPendingProvider = FutureProvider<List<Consultationmodel>>((ref)async{
  final repo= Patientrepo();
  return repo.getunresolved();
});

//responded provider (completed)
final patientCompletedProvider = FutureProvider<List<Consultationmodel>>((ref)async{
  final repo = Patientrepo();
  return repo.getresolved();
});


