import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/doctor/components/doctors_patient_hsitory_card.dart';

class DoctorHome extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: AssetImage('assets/images/image.png'),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Good Morning, Dr. Rajjo',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20.0),

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
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Stats",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                          children: [
                            SizedBox(

                              height: MediaQuery.of(context).size.width / 2.80,
                              width: MediaQuery.of(context).size.width / 2 - 25.0,
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
                                          Text("Total",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GoogleFonts.manrope().fontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.0),
                                      Text("12",
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
                           // SizedBox(width: 15.0),
                            SizedBox(

                              height: MediaQuery.of(context).size.width / 2.80,
                              width: MediaQuery.of(context).size.width / 2 - 25.0,
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
                                              fontFamily: GoogleFonts.manrope().fontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.0),
                                      Text("2",
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
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text("Upcoming Appointments",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          height: 150.0,
                          width: double.infinity,
                          
                          child:  DPHcard(caseType: "emergency", datetime: DateTime.now(), name: "priy ANSHU")
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          height: 150.0,
                          width: double.infinity,
                          
                          child:  DPHcard(caseType: "normal", datetime: DateTime.now(), name: "Dallu")
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                        height: 150.0,
                        width: double.infinity,
                        
                        child:  DPHcard(caseType: "normal", datetime: DateTime.now(), name: "DRG")
                      ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
      
    }
}