class Consultationmodel {
  final String id;
  final String doctorId;
  final String patientId;
  final String fullName;
  final String age;
  final String gender;
  final String contactNo;
  final String? problem;
  final String? lifeStyle;
  final String type;
  final String status;
  final String? doctorFileUrl;
  final String? patientFileUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DoctorInfo? doctor;

  Consultationmodel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.contactNo,
    this.problem,
    this.lifeStyle,
    required this.type,
    required this.status,
    this.doctorFileUrl,
    this.patientFileUrl,
    required this.createdAt,
    required this.updatedAt,
    this.doctor,
  });

  factory Consultationmodel.fromJson(Map<String, dynamic> json) {
    return Consultationmodel(
      id: json['_id'] ?? '',
      doctorId: json['doctor_id'] is String 
          ? json['doctor_id'] 
          : (json['doctor_id']?['_id'] ?? ''),
      patientId: json['patient_id'] ?? '',
      fullName: json['full_name'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      contactNo: json['contactNo'] ?? '',
      problem: json['Problem'],
      lifeStyle: json['life_style'],
      type: json['type'] ?? 'normal',
      status: json['status'] ?? 'pending',
      doctorFileUrl: json['doctorFileUrl'],
      patientFileUrl: json['patientFileUrl'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      doctor: json['doctor_id'] is Map 
          ? DoctorInfo.fromJson(json['doctor_id']) 
          : null,
    );
  }
}

class DoctorInfo {
  final String name;
  final String speciality;

  DoctorInfo({required this.name, required this.speciality});

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      name: json['name'] ?? '',
      speciality: json['speciality'] ?? '',
    );
  }
}