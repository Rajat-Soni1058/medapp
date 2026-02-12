import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/patient/providers/patientrepo.dart';

//pending provider (cancelled)
final patientPendingProvider = FutureProvider((ref)async{
  final repo= Patientrepo();
  return repo.getunresolved();
});

//responded provider (completed)
final patientCompletedProvider = FutureProvider((ref)async{
  final repo = Patientrepo();
  return repo.getresolved();
});


