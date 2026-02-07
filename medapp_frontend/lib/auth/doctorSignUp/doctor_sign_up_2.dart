import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';

class DoctorSignUp2 extends StatefulWidget {
  const DoctorSignUp2({super.key});

  @override
  State<DoctorSignUp2> createState() => _DoctorSignUp2State();
}

class _DoctorSignUp2State extends State<DoctorSignUp2> {
    TimeOfDay? startTime;
    TimeOfDay? endTime;
  @override
  Widget build(BuildContext context) {
    final phoneCtrl = TextEditingController();
    final licenseCtrl = TextEditingController();
    final feesCtrl = TextEditingController();
    final specialityCtrl = TextEditingController();


    //scaffold message//
    void showMessage(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.red)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    //time picker
    Future<void> pickTime(bool isStart) async {
      final picked = await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: const Color.fromARGB(255, 46, 46, 46),
                hourMinuteColor: Colors.grey.shade800,
                hourMinuteTextColor: Colors.white,
                dialBackgroundColor: Colors.grey.shade900,
                dialHandColor: Colors.blue,
                dialTextColor: Colors.white,
                entryModeIconColor: Colors.white,
                dayPeriodColor: const Color.fromARGB(255, 102, 189, 255),
                dayPeriodTextColor: Colors.white,
                dayPeriodBorderSide: const BorderSide(color: Colors.blue),
                helpTextStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              colorScheme: const ColorScheme.dark(
                primary: Colors.white, // OK / selected color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        setState(() {
          if (isStart) {
            startTime = picked;
          } else {
            endTime = picked;
          }
        });
      }
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
                  "Doctor's",
                  style: GoogleFonts.bungee(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'verification',
                  style: GoogleFonts.bungee(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                //name//
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
                  hint: 'phone number',
                  prefixIcon: Icons.phone,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'License ID',
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
                  controller: licenseCtrl,
                  hint: 'xxxxabcd',
                  prefixIcon: Icons.attach_email_outlined,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Fees',
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
                  controller: feesCtrl,
                  hint: 'Fees',
                  prefixIcon: Icons.currency_exchange,
                ),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Speciality',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                MyTextField(
                  controller: specialityCtrl,
                  hint: 'speciality',
                  prefixIcon: Icons.perm_identity,
                ),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Available Time',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => pickTime(true),
                      child: Text(
                        startTime == null
                            ? "Start Time"
                            : startTime!.format(context),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10,),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => pickTime(false),
                      child: Text(
                        endTime == null ? "End Time" : endTime!.format(context),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () {
                    if (phoneCtrl.text.isEmpty) {
                      showMessage(context, 'Please enter your phone number');
                      return;
                    }

                    if (licenseCtrl.text.isEmpty) {
                      showMessage(context, 'Please enter your license');
                      return;
                    }

                    if (!feesCtrl.text.contains('@')) {
                      showMessage(context, 'Please enter a fee');
                      return;
                    }

                    if (specialityCtrl.text.isEmpty) {
                      showMessage(context, 'Please enter speciality');
                      return;
                    }

                    // All validations passed
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => DoctorSignUp2()),
                    );
                  },

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
