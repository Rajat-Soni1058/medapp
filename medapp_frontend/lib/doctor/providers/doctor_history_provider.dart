import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/services/doctor_service.dart';

// provider which will return read response of Doctor Service
final doctorServiceProvider = Provider((ref) {
  return DoctorService();
});

//listening changes in the normal cases
final normalCaseProvider = FutureProvider((ref) async {
  final service = ref.read(doctorServiceProvider);
  return service.getNormalCases();
});

//listening changes in the emergency cases
final emergencyProvider = FutureProvider((ref)async{
  final service = ref.read(doctorServiceProvider);
  return service.getEmergencyCases();
});

//listening changes in the all cases
final allcasesProvider = FutureProvider((ref)async{
  final normal = await ref.watch(normalCaseProvider.future);
  final emergency = await ref.watch(emergencyProvider.future);
  return [...normal,...emergency];
});
