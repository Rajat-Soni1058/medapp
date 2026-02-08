import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';
import 'package:medapp_frontend/auth/login.dart';
import 'package:medapp_frontend/doctor/features/history.dart';
import 'package:medapp_frontend/doctor/features/home.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';

class PatientSignup extends ConsumerStatefulWidget {
  const PatientSignup({super.key});

  @override
  ConsumerState<PatientSignup> createState() => _PatientSignupState();
} 
class _PatientSignupState extends ConsumerState<PatientSignup> {
   final patientEmailCtrl = TextEditingController();
    final patientPassCtrl = TextEditingController();
    final confirmPatientPassCtrl = TextEditingController();
    final patientNameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

   @override 
   void dispose(){
    patientEmailCtrl.dispose();
     patientPassCtrl.dispose();
    confirmPatientPassCtrl.dispose();
    patientNameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
   }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), behavior: SnackBarBehavior.floating),
    );
  }
    Future<void> handleSignup() async {
      if(patientNameCtrl.text.isEmpty){
        showMessage('Please enter your name');
        return;
      }
      if (phoneCtrl.text.isEmpty) {
      showMessage('Please enter your Phone number');
      return;
    }
    if (patientEmailCtrl.text.isEmpty) {
      showMessage('Please enter your email');
      return;
    }
    if (!patientEmailCtrl.text.contains('@')) {
      showMessage('Please enter a valid email');
      return;
    }
    if (patientPassCtrl.text.isEmpty) {
      showMessage('Please enter password');
      return;
    }
    if (patientPassCtrl.text.length < 6) {
      showMessage('Password must be at least 6 characters');
      return;
    }
    if (confirmPatientPassCtrl.text.isEmpty) {
      showMessage('Please confirm your password');
      return;
    }
    if (patientPassCtrl.text != confirmPatientPassCtrl.text) {
      showMessage('Passwords do not match');
      return;
    }
    final success=await ref.read(authProvider.notifier).signUp({
        'name': patientNameCtrl.text.trim(),
        'email': patientEmailCtrl.text.trim(),
        'password': patientPassCtrl.text.trim(),
      'phoneNo': phoneCtrl.text.trim(),

    }, false );
    if(mounted && success) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DoctorsPatientHistory()),
        (route) => false,
      );
    }
    }




  @override

  Widget build(BuildContext context) {
   final isLoading =ref.watch(authProvider).isLoading;

   ref.listen(authProvider, (previous, next) {
      if (previous?.error != next.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
  
   });
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
                SizedBox(height: 10),
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
                    'Phone Number',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

                MyTextField(
                  controller: phoneCtrl,
                  hint: 'Phone Number',
                  prefixIcon: Icons.call,
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
                  hint: 'confirm password',
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: isLoading ? null : handleSignup,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Login()),
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
