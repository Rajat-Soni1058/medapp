import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/models/doctor_model.dart';
import 'package:medapp_frontend/models/soctype-symptom.dart';
import 'package:medapp_frontend/patient/features/chat/chat.dart';
import 'package:medapp_frontend/patient/features/consultAi/consultAi.dart';
import 'package:medapp_frontend/patient/features/patientForm/components/doctorcard.dart';
import 'package:medapp_frontend/patient/features/bmifeat.dart';
import 'package:medapp_frontend/patient/features/patientForm/patient_form.dart';
import 'package:medapp_frontend/patient/features/patientHistory/patient_history.dart';
import 'package:medapp_frontend/patient/providers/patient_provider.dart';
import 'package:medapp_frontend/patient/providers/patientprovider.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';
import 'package:medapp_frontend/auth/common_start.dart';
import 'package:medapp_frontend/theme/colors.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/services/firebase_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientHome extends ConsumerStatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends ConsumerState<PatientHome> {
  final ThemeColors themeColors = ThemeColors();

  final List<String> symptoms = [
    "Chest pain",
    "Upper body pain",
    "Shortness of breath",
    "Irregular heartbeat",
    "Weakness",
    "Dizziness",
    "Sweating without exercise",
    "Nausea",
    "Fainting",
    "Rash",
    "Itching",
    "Redness",
    "Dry skin",
    "Blisters",
    "Swelling",
    "Painful skin",
    "Skin discoloration",
    "Hair loss",
    "Fever",
    "Cough",
    "Sore throat",
    "Headache",
    "Fatigue",
    "Body aches",
    "Nausea",
    "Vomiting",
    "Diarrhea",
    "Runny or blocked nose",
    "Loss of appetite",
    "Headache",
    "Dizziness",
    "Numbness or tingling",
    // "Weakness",
    "Memory problems",
    "Difficulty concentrating",
    "Seizures",
    "Vision problems",
    "Speech difficulties",
    "Numbness",
    "Joint pain",
    "Back pain",
    "Muscle pain",
    "Swelling",
    "Stiffness",
    "Limited Motion",
    "Numbness",
    //"Weakness",
    "Deformity",
  ];
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredSymptoms = [];
  String _selectedSymptom = 'All';

  @override
  void initState() {
    super.initState();
    filteredSymptoms = symptoms;
    
    // Save FCM token to backend on home screen load
    _saveFCMToken();
    
    // Load all doctors by default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(doctorProvider.notifier).loadAllDoctors();
    });
  }
  
  Future<void> _saveFCMToken() async {
    try {
      await FirebaseService.saveFCMTokentobackend();
      print('Patient FCM token saved successfully');
    } catch (e) {
      print('Error saving patient FCM token: $e');
    }
  }

  void _filterDoctors() async {
    if (_selectedSymptom == 'All') {
      // Load all doctors when All is selected
      await ref.read(doctorProvider.notifier).loadAllDoctors();
    } else {
      final docSymptomMap = doctypesymptom();
      Set<String> targetSpecialities = {};

      docSymptomMap.symptoms.forEach((speciality, symptomList) {
        if (symptomList.any(
          (s) => s.toLowerCase() == _selectedSymptom.toLowerCase(),
        )) {
          targetSpecialities.add(speciality);
        }
      });

      // Load doctors for the first matching speciality
      if (targetSpecialities.isNotEmpty) {
        await ref
            .read(doctorProvider.notifier)
            .loadDoctors(targetSpecialities.first);
      }
    }
  }

  void _filterSymptoms(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSymptoms = symptoms;
      } else {
        filteredSymptoms = symptoms
            .where(
              (symptom) => symptom.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docs = ref.watch(doctorProvider);
    // List<DoctorModel> filterDoctors(String symptom) {
    //    List<DoctorModel> filteredocs = [];
    //    if(docs is List<DoctorModel>) {
    //      for(DoctorModel doc in docs as List<DoctorModel>) {
    //        if(doc.speciality.contains(symptom)) {
    //          filteredocs.add(doc);
    //        }
    //      }
    //    }
    //    return filteredocs;
    // };
    return Scaffold(
      backgroundColor: themeColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.person, color: Colors.white),
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            //fontWeight: //FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 160),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BMICalculator(),
                              ),
                            );
                          },
                          child: Icon(Icons.email),
                        ),
                        Icon(Icons.notifications),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15.0),
                      Icon(Icons.search, color: Colors.grey, size: 22),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            _filterSymptoms(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search diseases, symptoms...',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              fontFamily: GoogleFonts.oswald().fontFamily,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (_searchController.text.isEmpty) symptomsCard('All'),
                      ...List.generate(
                        filteredSymptoms.length,
                        (i) => symptomsCard(filteredSymptoms[i]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.greenAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY: 5.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                height: 25,
                                width: 180,
                                child: Center(
                                  child: Text(
                                    "Health Tip of the Day",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Stay hydrated! Drinking enough water is essential for overall health .",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                                  maxLines: null,
                                  softWrap: true,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                FontAwesomeIcons.heartPulse,
                                color: Colors.white.withOpacity(0.5),
                                size: 100.0,
                              ),
                            ],
                          ),
                          //SizedBox(height: 10.0),
                          Container(
                            //color: Colors.white,
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Read More',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12.0,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Icon(
                                  FontAwesomeIcons.arrowRight,
                                  color: Colors.blue,
                                  size: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                //history
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PatientHistory()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.greenAccent],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'History',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //doctor list
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Doctors",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // SizedBox(height: 10.0),
                docs.isLoading
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : docs.error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            docs.error!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    : docs.doctors.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No doctors found',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: docs.doctors.length,
                        itemBuilder: (context, index) {
                          final doc = docs.doctors[index];
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(doctorProvider.notifier)
                                  .selectDoctor(doc);
                            },
                            child: doctorcard(
                              doctorname: doc.name,
                              doctortype: doc.speciality,
                              doctorrating: "4.8",
                              navigateTo: PatientForm(doctor: doc),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "ConsultAi",
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return ConsultAi();
            },
          );
        },
        child: Icon(FontAwesomeIcons.robot, color: Colors.black),
      ),
    );
  }

  Widget symptomsCard(String symptom) {
    bool isSelected = _selectedSymptom == symptom;
    Color color = isSelected ? Colors.blue : Colors.white;
    Color textcolor = isSelected
        ? Colors.white
        : const Color.fromARGB(255, 64, 64, 64);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSymptom = symptom;
        });
        _filterDoctors();
      },
      child: SizedBox(
        height: 50,
        width: 100,
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                symptom,
                style: TextStyle(
                  color: textcolor,
                  fontFamily: GoogleFonts.manrope().fontFamily,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
