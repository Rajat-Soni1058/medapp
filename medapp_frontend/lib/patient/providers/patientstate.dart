class Patientstate {

String name;
String email;
String password;
String phoneNo;
String role='patient';

Patientstate({
  required this.name,
  required this.email,
  required this.password,
  required this.phoneNo,
  required this.role,
});
factory Patientstate.fromJson(Map<String,dynamic> json) {
  return Patientstate(name: json['name'], email: json['email'], password: json['password'], phoneNo: json['password'], role: json['role'], );
}


}
