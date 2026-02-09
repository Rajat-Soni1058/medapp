import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/patient/features/bmifeat.dart';
import 'package:medapp_frontend/theme/colors.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientHome extends ConsumerStatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}
class _PatientHomeState extends ConsumerState<PatientHome> {
  final ThemeColors themeColors = ThemeColors();

  final List<String> symptoms =[
    
    'Bawasir',
    'Cold',
    'Fever',
    'Stomache Ache',
    'Fatigue',
    'Headache',
    'Nausea',
    'Dizziness',
    'Cough',
    
  ]; 
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredSymptoms = [];

  @override
  void initState() {
    super.initState();
    filteredSymptoms = symptoms;
  }

  void _filterSymptoms(String query) {

    setState(() {
      if (query.isEmpty) {
        filteredSymptoms = symptoms;
      } else {
        filteredSymptoms = symptoms
            .where((symptom) => symptom.toLowerCase().contains(query.toLowerCase()))
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
    return Scaffold(
      backgroundColor: themeColors.bgColor,
      body: SafeArea(
        
        child: SingleChildScrollView(
           child : Padding(
             padding: const EdgeInsets.all(10.0),
             child: SizedBox(
              
               child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: AssetImage('assets/images/image.png'),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome ',
                              style: GoogleFonts.poppins(
                                fontSize: 10.0,
                                //fontWeight: //FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Dallu',
                              style: GoogleFonts.poppins(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  BMICalculator()),);
                              },
                              child: Icon(
                                Icons.email,
                              ),
                            ),
                            Icon(
                              Icons.notifications,
                            ),
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
                          if (_searchController.text.isEmpty)
                            symptomsCard('All', Colors.blue, Colors.white),
                          ...List.generate(filteredSymptoms.length, (i) => symptomsCard(filteredSymptoms[i],  Colors.white, const Color.fromARGB(255, 64, 64, 64))),
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
                          gradient: LinearGradient(colors: [Colors.blue, Colors.greenAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
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
                                      child: Center(child: Text("Health Tip of the Day",  style: TextStyle( color: const Color.fromARGB(255, 255, 255, 255), fontFamily: GoogleFonts.inter().fontFamily),)),
                                    
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
                      )
                  ],
               ),
             ),
           ),
        ),
      ),
    );
  }
  Widget symptomsCard(String symptom, Color color, Color textcolor){
    return SizedBox(
      height : 50,
      width: 100,
      child: Card(
        color: color,
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),),
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
    );
  }
}