import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/doctor/components/doctors_patient_hsitory_card.dart';
import 'package:medapp_frontend/doctor/providers/doctorprovider.dart';
import 'package:medapp_frontend/patient/providers/patientprovider.dart';
import 'package:medapp_frontend/doctor/features/history.dart';

class DoctorHome extends ConsumerStatefulWidget{
    @override
    ConsumerState<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends ConsumerState<DoctorHome> {
    bool isem = true;

    @override
    Widget build(BuildContext context) {
        
        final empat = ref.watch(emergencycasesprovider);
        final normalpat=ref.watch(normalcasesprovider);
        final doc = ref.watch(doctorNameProvider);
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
            body: SingleChildScrollView(
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                     
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, children: [ CircleAvatar( radius: 20.0, child: Icon(Icons.person), ), SizedBox(width: 10.0), doc.when( data: (name) => Text( 'Good Morning, Dr. $name', style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold, ), ), loading: () => Text('Loading...'), error: (err, stack) => Text('Good Morning, Dr. Doctor'), ), SizedBox(width: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.notifications, size: 24.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Dashboard",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorsPatientHistory(),
                              ),
                            );
                          },
                          child: SizedBox(
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
                                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.white.withOpacity(0.2))),
                                      height: 25,
                                      width: 180,
                                      child: Center(child: Text("Your satisfied patients",  style: TextStyle( color: const Color.fromARGB(255, 255, 255, 255), fontFamily: GoogleFonts.inter().fontFamily),)),
                                    
                                  ),
                                ),
                              ),
                            //  SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "History ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: GoogleFonts.inter(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ).fontFamily,
                                      ),
                                      maxLines: null,
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(FontAwesomeIcons.heartPulse, color: Colors.white.withOpacity(0.5), size: 100.0),
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
                                          fontFamily: GoogleFonts.manrope().fontFamily,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Icon(FontAwesomeIcons.arrowRight, color: Colors.blue, size: 10.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                          children: [
                            SizedBox(

                              height: MediaQuery.of(context).size.width / 2.80,
                              width: MediaQuery.of(context).size.width / 2 - 25.0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isem = false;
                                  });
                                },
                                child: Card(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month,size: 25.0, color: Colors.blue,),
                                            SizedBox(width: 10.0),
                                            Text("Normal Cases",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: GoogleFonts.manrope().fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Text("${normalpat.asData?.value.length ?? 0}",
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.oswald().fontFamily,
                                          ),
                                        ),
                                      ],
                                
                                    ),
                                  ),
                                ),
                              ),
                            ),
                           // SizedBox(width: 15.0),
                            SizedBox(

                              height: MediaQuery.of(context).size.width / 2.80,
                              width: MediaQuery.of(context).size.width / 2 - 25.0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isem = true;
                                  });
                                },
                                child: Card(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.emergency,size: 25.0, color: Colors.red,),
                                            SizedBox(width: 10.0),
                                            Text("Emergency",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                ).fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Text("${empat.asData?.value.length ?? 0}",
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.oswald().fontFamily,
                                          ),
                                        ),
                                      ],
                                
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text(isem ? "Emergency Cases" : "Normal Cases",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        isem ? EmergencyList() : NormalList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          
    }
}
class EmergencyList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empat = ref.watch(emergencycasesprovider);

    return empat.when(
      data: (cases) {
        if (cases.isEmpty) {
          return Center(child: Text('No Emergency Cases'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cases.length,
          itemBuilder: (context, index) {
            final consult = cases[index];
            return DPHcard(
              caseType: consult.type,
              datetime: consult.createdAt,
              name: consult.fullName,
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading cases')),
    );
  }
}

class NormalList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalpat = ref.watch(normalcasesprovider);

    return normalpat.when(
      data: (cases) {
        if (cases.isEmpty) {
          return Center(child: Text('No Normal Cases'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cases.length,
          itemBuilder: (context, index) {
            final consult = cases[index];
            return DPHcard(
              caseType: consult.type,
              datetime: consult.createdAt,
              name: consult.fullName,
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading cases')),
    );
  }
} 