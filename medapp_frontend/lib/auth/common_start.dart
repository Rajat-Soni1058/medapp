import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/doctorSignUp/doctor_sign_up_1.dart';
import 'package:medapp_frontend/auth/patient_signUp.dart';

class CommonStart extends StatefulWidget {
  const CommonStart({super.key});

  @override
  State<CommonStart> createState() => _CommonStartState();
}

class _CommonStartState extends State<CommonStart> {
      bool isDoctor = false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
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
                'Where trust meets treatment',
                style: GoogleFonts.manrope(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(height: 60),
              Text(
                'How would you like to',
                style: GoogleFonts.manrope(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'continue?',
                style: GoogleFonts.manrope(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Select your profile type to customize your',
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  color: const Color.fromARGB(118, 0, 180, 96),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'experience',
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  color: const Color.fromARGB(122, 0, 180, 96),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              ListTile(
                tileColor: const Color.fromARGB(255, 238, 238, 238),
                selected: !isDoctor,
                selectedTileColor: const Color.fromARGB(255, 0, 62, 113),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onTap: () {
                  setState(() {
                    isDoctor = false;
                  });
                },

                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.lightBlue.withOpacity(0.6),
                  ),
                  height: 30,
                  width: 30,

                  child: Icon(Icons.favorite, color: Colors.blueAccent),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    'I am Patient',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: (isDoctor)? Colors.black:Colors.white,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    'Book appointments and consult with specialists near you.',
                    style: GoogleFonts.manrope(
                      color: (isDoctor)?const Color.fromARGB(255, 129, 129, 129):Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                tileColor: const Color.fromARGB(255, 238, 238, 238),
                selected: isDoctor,
                selectedTileColor:  const Color.fromARGB(255, 0, 62, 113),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onTap: () {
                  setState(() {
                    isDoctor = true;
                  });
                },

                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.lightBlue.withOpacity(0.6),
                  ),
                  height: 30,
                  width: 30,

                  child: Icon(Icons.favorite, color: Colors.blueAccent),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    'I am Doctor',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: (isDoctor)? Colors.white:Colors.black,),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    'Committed to patient health and well-being.',
                    style: GoogleFonts.manrope(
                      color:(isDoctor)?const Color.fromARGB(255, 233, 233, 233):const Color.fromARGB(255, 129, 129, 129),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60,),
               ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 18, 110, 186),
                  ),
                  onPressed: () {
                    
                    
                    // All validations passed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>(!isDoctor)?PatientSignup() : DoctorSignUp1(),
                      ),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.bungee(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
