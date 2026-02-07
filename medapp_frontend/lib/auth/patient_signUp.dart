import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';
import 'package:medapp_frontend/doctor/features/history.dart';
import 'package:medapp_frontend/doctor/features/home.dart';

class PatientSignup extends StatelessWidget {
  const PatientSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final patientEmailCtrl = TextEditingController();
    final patientPassCtrl = TextEditingController();
    final confirmPatientPassCtrl = TextEditingController();
    final patientNameCtrl = TextEditingController();
//scaffold message//
    void showMessage(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(color: Colors.red),), behavior: SnackBarBehavior.floating),
      );
    }

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
                SizedBox(height: 60),
                Text(
                  'Sign Up',
                  style: GoogleFonts.bungee(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
                  prefixIcon: Icons.email_outlined,
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
                  onPressed: () {
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

                    if (confirmPatientPassCtrl.text.isEmpty) {
                      showMessage(context, 'Please confirm your password');
                      return;
                    }

                    if (patientPassCtrl.text != confirmPatientPassCtrl.text) {
                      showMessage(context, 'Passwords do not match');
                      return;
                    }

                    // All validations passed
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorsPatientHistory(),
                      ),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'SignUp',
                      style: GoogleFonts.bungee(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {},
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
