import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/patient/features/patientForm/forms/emergency_form.dart';
import 'package:medapp_frontend/patient/features/patientForm/forms/normal_form.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> with SingleTickerProviderStateMixin{
    late TabController _tabController;
    @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});//setstate used instead of riverpod
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      body: Stack(
        
        children: [
          //lower part//
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 230),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [NormalForm(),EmergencyForm()],
                  ),
                ),
              ],
            ),
          ),
          //upper part//
          Container(
            height: 235,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //top part of app bar
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                      Text(
                        'Booking Details',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      
                    ],
                  ),
                  //top part of custom app bar ends
                  //doctor info//
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    //
                    child: Column(
                      children: [
                        Text('Dr.Sarah Jenkins',style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text('Cardiologist',style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.blue),),
                      ],
                    ),
                  )
                ),
                //doctor info ends here
                SizedBox(height: 20),
                //three tabs -> all cases , emergency , normal//
                TabBar(
                  indicator: BoxDecoration(
                    // border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                    color: (_tabController.index == 0)?Color(0xFF137FEC):Colors.red,
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: _tabController,
                  tabs: [
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: Tab(
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: (_tabController.index != 0)
                                ? Border.all(width: 1.5,color: const Color.fromARGB(255, 199, 199, 199))
                                : null,
                          ),
                          child: Center(child: Text('Normal')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: Tab(
                        child: Container(
                           height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: (_tabController.index != 1)
                                ? Border.all(width: 1.5,color: const Color.fromARGB(255, 199, 199, 199))
                                : null,
                          ),
                          child: Center(child: Text('Emergency')),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )

    );
  }
}