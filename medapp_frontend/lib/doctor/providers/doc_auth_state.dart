class DocAuthState {
  String email;
  String password;
  String name;
  String phone;
  String licenceId;
  String availTime;
  String fees;
  String speciality;
  String role;
  DocAuthState({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.licenceId,
    required this.availTime,
    required this.fees,
    required this.speciality,
    this.role = 'doctor',
  });
  factory DocAuthState.fromJson(Map<String,dynamic> json){
    return DocAuthState(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      licenceId: json['licenceId'] ?? '',
      availTime: json['availTime'] ?? '',
      fees: json['fees'] ?? '',
      speciality: json['speciality'] ?? '',
      role: json['role'] ?? 'doctor',
    );
  }

}