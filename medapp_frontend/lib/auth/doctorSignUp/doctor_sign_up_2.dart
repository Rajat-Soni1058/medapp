import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';
import 'package:medapp_frontend/auth/login.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';

class DoctorSignUp2 extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String password;
  const DoctorSignUp2({super.key, required this.name, required this.email, required this.password});

  

  @override
  ConsumerState<DoctorSignUp2> createState() => _DoctorSignUp2State();
}

class _DoctorSignUp2State extends ConsumerState<DoctorSignUp2> {
    TimeOfDay? startTime;
    TimeOfDay? endTime;
     final phoneCtrl = TextEditingController();
    final licenseCtrl = TextEditingController();
    final feesCtrl = TextEditingController();
    final specialityCtrl = TextEditingController();

    void dispose(){
      phoneCtrl.dispose();
      licenseCtrl.dispose();
      feesCtrl.dispose();
      specialityCtrl.dispose();
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
    String formatTimeOfDay(TimeOfDay time) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
    Future<void> handleSignup() async {
    if (phoneCtrl.text.isEmpty) {
      showMessage(context, 'Please enter phone number');
      return;
    }
    if (licenseCtrl.text.isEmpty) {
      showMessage(context, 'Please enter license ID');
      return;
    }
    if (feesCtrl.text.isEmpty) {
      showMessage(context, 'Please enter consultation fees');
      return;
    }
    if (specialityCtrl.text.isEmpty) {
      showMessage(context,'Please enter your speciality');
      return;
    }
    if (startTime == null || endTime == null) {
      showMessage(context,'Please select available time');
      return;
    }

    final availTime =
        '${formatTimeOfDay(startTime!)} - ${formatTimeOfDay(endTime!)}';

    final success = await ref.read(authProvider.notifier).signUp({
      'name': widget.name,
      'email': widget.email,
      'password': widget.password,
      'phone': phoneCtrl.text.trim(),
      'licenceId': licenseCtrl.text.trim(),
      'fees': int.tryParse(feesCtrl.text.trim()) ?? 0,
      'speciality': specialityCtrl.text.trim(),
      'availTime': availTime,
    }, true);

    if (mounted && success) {
      showMessage(context, 'Doctor signup successful! Please login.');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Login(isDoctor: true)),
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
   

    //time picker
   

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
                    isLoading? null : handleSignup();
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
