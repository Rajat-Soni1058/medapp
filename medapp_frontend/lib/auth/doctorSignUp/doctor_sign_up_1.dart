import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';
import 'package:medapp_frontend/auth/doctorSignUp/doctor_sign_up_2.dart';
import 'package:medapp_frontend/auth/login.dart';
import 'package:medapp_frontend/doctor/features/history.dart';

class DoctorSignUp1 extends StatefulWidget {
  const DoctorSignUp1({super.key});

  @override
  State<DoctorSignUp1> createState() => _DoctorSignUp1State();
}

class _DoctorSignUp1State extends State<DoctorSignUp1> {
  final patientEmailCtrl = TextEditingController();
    final patientPassCtrl = TextEditingController();
    final confirmPatientPassCtrl = TextEditingController();
    final patientNameCtrl = TextEditingController();

    @override 
    void dispose(){
      patientNameCtrl.dispose();
      patientEmailCtrl.dispose();
      patientPassCtrl.dispose();
      confirmPatientPassCtrl.dispose();
      super.dispose();
    }
     void showMessage(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.red)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    void handleNext() {
      if (patientNameCtrl.text.isEmpty) {
        showMessage(context, 'Please enter your name');
        return;
      }
      if (patientEmailCtrl.text.isEmpty) {
        showMessage(context, 'Please enter your email');
        return;
      }
      if (!patientEmailCtrl.text.contains('@')) {
        showMessage(context, 'Please enter a valid email');
        return;
      }
      if (patientPassCtrl.text.isEmpty) {
        showMessage(context, 'Please enter password');
        return;
      }
      if (patientPassCtrl.text.length < 8) {
        showMessage(context, 'Password must be at least 8 characters');
        return;
      }
      if (!RegExp(r'[A-Z]').hasMatch(patientPassCtrl.text)) {
        showMessage(context, 'Password must contain at least one uppercase letter');
        return;
      }
      if (!RegExp(r'[0-9]').hasMatch(patientPassCtrl.text)) {
        showMessage(context, 'Password must contain at least one number');
        return;
      }
      if (!RegExp(r'[^A-Za-z0-9]').hasMatch(patientPassCtrl.text)) {
        showMessage(context, 'Password must contain at least one special character');
        return;
      }
      if (confirmPatientPassCtrl.text.isEmpty) {
        showMessage(context, 'Please confirm your password');
        return;
      }
      if (patientPassCtrl.text != confirmPatientPassCtrl.text) {
        showMessage(context, 'Passwords do not match');
        return;
      }

      // All validations passed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DoctorSignUp2(
          name: patientNameCtrl.text.trim(),
          email: patientEmailCtrl.text.trim(),
          password: patientPassCtrl.text.trim(),
        )),
      );
    }
  @override
  Widget build(BuildContext context) {
    
    //scaffold message//
   

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.asset('assets/images/consultOne.png'),
                ),
                SizedBox(height: 10),

                Text(
                  'Because every patient matters',
                  style: GoogleFonts.manrope(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Text(
                  "Doctor's",
                  style: GoogleFonts.bungee(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Sign Up',
                  style: GoogleFonts.bungee(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                //name//
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

                MyTextField(
                  controller: patientNameCtrl,
                  hint: 'full name',
                  prefixIcon: Icons.perm_identity,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Email',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //mail field//
                MyTextField(
                  controller: patientEmailCtrl,
                  hint: 'abc123@email.com',
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Password',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

                //password//
                MyTextField(
                  controller: patientPassCtrl,
                  hint: 'password',
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Confirm Password',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                MyTextField(
                  controller: confirmPatientPassCtrl,
                  hint: 'confrim password',
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: handleNext,

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Next',
                      style: GoogleFonts.bungee(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Login(isDoctor: true)),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
