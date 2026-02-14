import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/models/doctor_model.dart';
import 'package:medapp_frontend/patient/features/chat/chat.dart';
import 'package:medapp_frontend/patient/features/patientForm/components/my_text_field.dart';
import 'package:medapp_frontend/patient/features/patientForm/components/titles.dart';
import 'package:medapp_frontend/patient/providers/patientrepo.dart';

class EmergencyForm extends StatefulWidget {
  final DoctorModel doctor;
  const EmergencyForm({super.key, required this.doctor});

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

  bool isLoading = false;
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
        withData: true,
      );

      if (result != null) {
        setState(() {
          selectedFile = result.files.first;
        });
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
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Titles(
              title: 'Patient Details',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 10),

            // FULL NAME
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
            const SizedBox(height: 10),

            // AGE
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
            const SizedBox(height: 10),

            // GENDER
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
            const SizedBox(height: 10),

            // PHONE
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
            const SizedBox(height: 10),

            // PROBLEM
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
              hint: 'symptoms',
              maxlines: 30,
              maxlength: 200,
            ),
            const SizedBox(height: 10),

            // LIFESTYLE
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
              hint: 'personal habits and more information',
              maxlines: 30,
              maxlength: 200,
            ),

            // FILE PICKER
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
              onTap: pickFile,
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 235, 235, 235),
                ),
                child: selectedFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload, color: Colors.blue),
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.file_copy, color: Colors.blue),
                          Text(selectedFile!.name),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 30),

            // SUBMIT BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty ||
                    ageCtrl.text.trim().isEmpty ||
                    genderCtrl.text.trim().isEmpty ||
                    phoneCtrl.text.trim().isEmpty) {
                  showSnack("Please fill required fields");
                  return;
                }

                setState(() => isLoading = true);

                try {
                  final repo = Patientrepo();

                  final response = await repo.submitForm(
                    doctorId: widget.doctor.id,
                    fullName: nameCtrl.text.trim(),
                    age: ageCtrl.text.trim(),
                    gender: genderCtrl.text.trim(),
                    contactNo: phoneCtrl.text.trim(),
                    problem: problemCtrl.text.trim(),
                    lifeStyle: lifeStyleCtrl.text.trim(),
                    type: "emergency", // ✅ Correct type
                    file: selectedFile,
                  );

                  print("FULL BACKEND RESPONSE: $response");

                  String? consultationId;
                  if (response is Map<String, dynamic>) {
                    dynamic consultData = response['consultation'] ?? response['msg'] ?? response['data'];
                    if (consultData is Map<String, dynamic>) {
                      consultationId = (consultData['_id'] ?? consultData['id'])?.toString();
                    } else if (consultData is String) {
                      consultationId = consultData;
                    }
                  }

                  if (consultationId == null || consultationId.isEmpty) {
                    print("WARN: consultation id not found, using doctor id as fallback");
                    consultationId = widget.doctor.id;
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChatScreen(consultationId: consultationId!),
                    ),
                  );
                } catch (e) {
                  showSnack(e.toString().replaceAll("Exception: ", ""));
                } finally {
                  setState(() => isLoading = false);
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Padding(
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
    );
  }
}
