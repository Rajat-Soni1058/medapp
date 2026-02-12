class PatientState {
  final String name;
  final String email;
  final String phoneNo;
  final String role;

  PatientState({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.role,
  });

  factory PatientState.fromJson(Map<String, dynamic> json) {
    return PatientState(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      role: json['role'] ?? 'patient',
    );
  }
}
