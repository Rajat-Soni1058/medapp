import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/doctor/components/doctors_patient_hsitory_card.dart';

class DoctorsPatientHistory extends StatefulWidget {
  const DoctorsPatientHistory({super.key});

  @override
  State<DoctorsPatientHistory> createState() => _DoctorsPatientHistoryState();
}

class _DoctorsPatientHistoryState extends State<DoctorsPatientHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          //below list part//
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 210),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [buildlist('all cases'), buildlist('emergency'),buildlist('normal')],
                  ),
                ),
              ],
            ),
          ),
          //below list part ends
    
          //custom app bar
          Container(
            height: 235,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                      Text(
                        'Patient History',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.calendar_month, color: Colors.black),
                      ),
                    ],
                  ),
                  //top part of custom app bar ends
                  //search bar of custom app bar//
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: SearchBar(
                    hintText: 'Search by patient name',
                    hintStyle: WidgetStateProperty.all(
                      GoogleFonts.manrope(fontSize: 15, color: Colors.grey),
                    ),
                    leading: Icon(Icons.search, color: Colors.grey),
                    backgroundColor: WidgetStateProperty.all(
                      Color.fromARGB(255, 242, 242, 242),
                    ),
                    elevation: WidgetStateProperty.all(1),
                  ),
                ),
                //search bar ends here
                SizedBox(height: 30),
                //three tabs -> all cases , emergency , normal//
                TabBar(
                  indicator: BoxDecoration(
                    // border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFF137FEC),
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: _tabController,
                  tabs: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Tab(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: (_tabController.index != 0)
                                ? Border.all(width: 1.5,color: const Color.fromARGB(255, 199, 199, 199))
                                : null,
                          ),
                          child: Center(child: Text('All Cases')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Tab(
                        child: Container(
                           height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: (_tabController.index != 1)
                                ? Border.all(width: 1.5,color: const Color.fromARGB(255, 199, 199, 199))
                                : null,
                          ),
                          child: Center(child: Text('Emergency')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Tab(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: (_tabController.index != 2)
                                ? Border.all(width: 1.5,color: const Color.fromARGB(255, 199, 199, 199))
                                : null,
                          ),
                          child: Center(child: Text('Normal')),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //custom app bar ends
        ],
      ),
    );
  }
}

Widget buildlist(String cases) {
  return ListView(
    padding: const EdgeInsets.only(top: 16),
    children: [
      if (cases == 'all cases')
        DPHcard(
          caseType: 'emergency',
          datetime: DateTime.now(),
          name: 'Raj Gupta',
        )
      else if (cases == 'emergency')
        DPHcard(
          caseType: 'emergency',
          datetime: DateTime.now(),
          name: 'Utkarsh Rastogi',
        )
      else
        DPHcard(
          caseType: 'normal',
          datetime: DateTime.now(),
          name: 'Rajat Soni',
        ),
    ],
  );
}

