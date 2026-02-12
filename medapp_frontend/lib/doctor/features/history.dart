import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/doctor/components/doctors_patient_hsitory_card.dart';
import 'package:medapp_frontend/doctor/providers/doctor_history_provider.dart';
import 'package:medapp_frontend/doctor/providers/doctorprovider.dart';

class DoctorsPatientHistory extends ConsumerStatefulWidget {
  const DoctorsPatientHistory({super.key});

  @override
  ConsumerState<DoctorsPatientHistory> createState() =>
      _DoctorsPatientHistoryState();
}

class _DoctorsPatientHistoryState extends ConsumerState<DoctorsPatientHistory> {
  bool isem = true;
  bool all =true;

  @override
  Widget build(BuildContext context) {
   final allhistory=ref.watch(historycasesprovider);
   final normalCases = allhistory.when(
      data: (cases) => cases.where((caseItem) => caseItem.type == "normal").toList(),
      loading: () => [],
      error: (err, stack) => [],
    );

  final emergencyCases= allhistory.when(
    data: (cases) => cases.where((caseItem) => caseItem.type == "emergency").toList(),
    loading: () => [],
    error: (err, stack) => [],
  );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Case Types",
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
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              all =true;
                              isem = false;
                            });
                          },
                          child: Card(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        size: 16.0,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "All Cases",
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                                GoogleFonts.manrope().fontFamily,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "${allhistory.asData?.value.length ?? 0}",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.oswald().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isem = false;
                              all=false;
                            });
                          },
                          child: Card(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 16.0,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Normal",
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                                GoogleFonts.manrope().fontFamily,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "${normalCases.length}",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.oswald().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isem = true;
                              all = false;
                            });
                          },
                          child: Card(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.emergency,
                                        size: 16.0,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Emergency",
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                                GoogleFonts.manrope().fontFamily,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "${emergencyCases.length}",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.oswald().fontFamily,
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
                    child: Text(
                      all ? "All Cases" : 
                      isem  ? "Emergency Cases" : "Normal Cases",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  all
                      ? AllCasesList()
                      : (isem ? HistoryEmergencyList() : HistoryNormalList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryEmergencyList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final  allhistory= ref.watch(historycasesprovider);  

    return allhistory.when(
      data: (cases) {
        final emergencyCases = cases.where((caseItem) => caseItem.type == "emergency").toList();
        
        if (emergencyCases.isEmpty) {
          return Center(child: Text('No Emergency Cases'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: emergencyCases.length,
          itemBuilder: (context, index) {
            final caseItem = emergencyCases[index];
            return DPHcard(
              caseType: caseItem.type,
              datetime: caseItem.createdAt,
              name: caseItem.fullName,
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading cases')),
    );
  }
}

class HistoryNormalList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allhistory = ref.watch(historycasesprovider);

    return allhistory.when(
      data: (cases) {
        final normalCases =
            cases.where((caseItem) => caseItem.type == "normal").toList();
        
        if (normalCases.isEmpty) {
          return Center(child: Text('No Normal Cases'));
        }
        
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: normalCases.length,
          itemBuilder: (context, index) {
            final caseItem = normalCases[index];
            return DPHcard(
              caseType: caseItem.type,
              datetime: caseItem.createdAt,
              name: caseItem.fullName,
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading cases')),
    );
  }
}
class AllCasesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCases = ref.watch(historycasesprovider);

    return allCases.when(
      data: (cases) {
        if (cases.isEmpty) {
          return Center(child: Text('No Cases'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cases.length,
          itemBuilder: (context, index) {
            final caseItem = cases[index];
            return DPHcard(
              caseType: caseItem.type,
              datetime: caseItem.createdAt,
              name: caseItem.fullName,
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading cases')),
    );
  }
}
