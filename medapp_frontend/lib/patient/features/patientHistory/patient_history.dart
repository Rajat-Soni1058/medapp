import 'package:flutter/material.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> with SingleTickerProviderStateMixin{
  late  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    },);
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
          //Upper part
          Column(
            children: [
              SizedBox(height: 230,),
              Expanded(child: TabBarView(
                controller: _tabController,
                children: []))
            ],
          )
        ],
      ),
    );
  }
}