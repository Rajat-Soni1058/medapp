import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/patient/features/patientForm/components/my_text_field.dart';
import 'package:medapp_frontend/patient/features/patientForm/components/titles.dart';

class EmergencyForm extends StatefulWidget {
  const EmergencyForm({super.key});

  @override
  State<EmergencyForm> createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final problemCtrl = TextEditingController();
  final lifeStyleCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  PlatformFile? selectedFile;

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    genderCtrl.dispose();
    problemCtrl.dispose();
    lifeStyleCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      );

      if (result != null) {
        setState(() {
          selectedFile = result.files.first;
        });
      } else {
        print('cancelled');
      }
    }

    void showSnack(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      body: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Titles(
                title: 'Patient Details',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              //FULL NAME
              Row(
                children: [
                  Titles(
                    title: 'Patient full name',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (required)*',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),

              PatientFormTextField(controller: nameCtrl, hint: 'full name'),
              SizedBox(height: 10),
              //AGE
              Row(
                children: [
                  Titles(
                    title: 'Patient Age',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (required)*',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              PatientFormTextField(controller: ageCtrl, hint: 'age'),
              SizedBox(height: 10),

              //GENDER
              Row(
                children: [
                  Titles(
                    title: 'Patient Gender',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (required)*',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              PatientFormTextField(controller: genderCtrl, hint: 'gender'),

              SizedBox(height: 10),

              //Phone Number//
              Row(
                children: [
                  Titles(
                    title: 'Patient Contact Information',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (required)*',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              PatientFormTextField(controller: phoneCtrl, hint: 'phone number'),

              SizedBox(height: 10),

              //PROBLEM//
              Row(
                children: [
                  Titles(
                    title: 'Patient Problem',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (optional)',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              PatientFormTextField(
                controller: problemCtrl,
                hint: 'symtoms',
                maxlines: 30,
                maxlength: 200,
              ),

              SizedBox(height: 10),

              //LifeStyle//
              Row(
                children: [
                  Titles(
                    title: 'Patient LifeStyle',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (optional)',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              PatientFormTextField(
                controller: lifeStyleCtrl,
                hint: 'personal habbits and more information',
                maxlines: 30,
                maxlength: 200,
              ),

              //File Picker//
              Row(
                children: [
                  Titles(
                    title: 'Upload Details',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Titles(
                    title: ' (optional)',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: pickFile,
                child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 235, 235, 235),
                  ),
                  child: (selectedFile == null)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.cloud_upload,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Tap to upload files',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'PDF,JPG,PNG,JPEG',
                              style: GoogleFonts.manrope(color: Colors.grey),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.file_copy, color: Colors.blue),
                              Text(
                                selectedFile!.name,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (nameCtrl.text.trim().isEmpty) {
                    showSnack('Please enter patient name');
                    return;
                  }

                  if (ageCtrl.text.trim().isEmpty) {
                    showSnack('Please enter patient age');
                    return;
                  }

                  if (genderCtrl.text.trim().isEmpty) {
                    showSnack('Please enter patient gender');
                    return;
                  }

                  if (phoneCtrl.text.trim().isEmpty) {
                    showSnack('Please enter contact number');
                    return;
                  }

                  //  All validations passed
                  showSnack('All fields are valid 👍');
                  // Navigate or submit
                },

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Proceed to payment >',
                    style: GoogleFonts.bungee(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
