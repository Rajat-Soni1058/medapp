import 'package:medapp_frontend/models/doctor_model.dart';

class Consultationmodel {
  final String id;
  final String fullName;
  final DateTime createdAt;
  final String status;
  final String type;
  final String? patientFileUrl;
  final String? doctorFileUrl;
  final String doctorId;
  final DoctorModel? doctor;

  Consultationmodel({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.status,
    required this.type,
    this.patientFileUrl,
    this.doctorFileUrl,
    required this.doctorId,
    this.doctor,
  });

  factory Consultationmodel.fromJson(Map<String, dynamic> json) {
    try {
      DoctorModel? parsedDoctor;
      if (json['doctor_id'] != null) {
        final doctorData = json['doctor_id'];
        if (doctorData is Map<String, dynamic>) {
          parsedDoctor = DoctorModel.fromJson(doctorData);
        } else if (doctorData is String) {
          print("WARNING: doctor_id is a string, not a map: $doctorData");
        }
      }

      return Consultationmodel(
        id: json['_id'] ?? '',
        fullName: json['full_name'] ?? '',
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
        status: json['status'] ?? 'pending',
        type: json['type'] ?? 'normal',
        patientFileUrl: json['patientFileUrl'],
        doctorFileUrl: json['doctorFileUrl'],
        doctorId: json['doctor_id'] is String ? json['doctor_id'] : (json['doctor_id']?['_id'] ?? ''),
        doctor: parsedDoctor,
      );
    } catch (e) {
      print("ERROR in Consultationmodel.fromJson: $e");
      rethrow;
    }
  }
}


class DoctorInfo {
  final String name;
  final String speciality;

  DoctorInfo({required this.name, required this.speciality});

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(name: json['name'], speciality: json['speciality']);
  }
}
