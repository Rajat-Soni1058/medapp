import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/doctor/providers/consultationmodel.dart';
import 'package:medapp_frontend/patient/features/chat/chat.dart';
import 'package:medapp_frontend/patient/features/patientHistory/components/PVHCard.dart';
import 'package:medapp_frontend/patient/providers/patient_provider.dart';

class PatientHistory extends ConsumerStatefulWidget {
  const PatientHistory({super.key});

  @override
  ConsumerState<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends ConsumerState<PatientHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Widget buildlist(AsyncValue<List<Consultationmodel>> asyncCases) {
    return asyncCases.when(
      data: (cases) {
        if (cases.isEmpty) {
          return const Center(child: Text('No History Found'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            ref.refresh(patientCompletedProvider);
            ref.refresh(patientPendingProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final consultation = cases[index];
              return Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: PVHCard(
                  statusType: consultation.status == 'responded'
                      ? "completed"
                      : "cancelled",
                  datetime: consultation.createdAt,
                  name: consultation.fullName,
                  navigateTo: ChatScreen(consultationId: consultation.id),
                ),
              );
            },
          ),
        );
      },
      error: (e, _) {
        return Center(child: Text("Error: $e"));
      },
      loading: () {
        return SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
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
          //Lower part
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 230),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildlist(ref.watch(patientCompletedProvider)),
                      buildlist(ref.watch(patientPendingProvider)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Upper part
          Container(
            height: 240,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 25),
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
                        'Visit History',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  //top part of custom app bar ends
                ),
                //search bar
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: SearchBar(
                    hintText: 'Search by name',
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

                //search bar ends
                SizedBox(height: 20),
                //two tabs -> completed,cancelled//
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 235, 235, 235),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TabBar(
                        indicator: BoxDecoration(
                          // border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        controller: _tabController,
                        tabs: [
                          SizedBox(
                            height: 40,
                            width: 180,
                            child: Tab(
                              child: Text(
                                'Completed',
                                style: TextStyle(
                                  color: (_tabController.index == 0)
                                      ? Colors.blue
                                      : const Color.fromARGB(
                                          255,
                                          123,
                                          123,
                                          123,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 180,
                            child: Tab(
                              child: Text(
                                'Cancelled',
                                style: TextStyle(
                                  color: (_tabController.index == 1)
                                      ? Colors.red
                                      : const Color.fromARGB(
                                          255,
                                          123,
                                          123,
                                          123,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
