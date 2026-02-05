import 'package:flutter/material.dart';

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
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: AssetImage('assets/doctor_avatar.png'),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Good Morning, Dr. Smith',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Icon(Icons.notifications, size: 24.0),
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
                              height: MediaQuery.of(context).size.width / 2 - 30.0,
                              width: MediaQuery.of(context).size.width / 2 - 30.0,
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                           // SizedBox(width: 15.0),
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 2 - 30.0,
                              width: MediaQuery.of(context).size.width / 2 - 30.0,
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
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
                          height: 220.0,
                          width: double.infinity,
                          
                          child:  Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          height: 180.0,
                          width: double.infinity,
                          
                          child:  Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                        height: 220.0,
                        width: double.infinity,
                        
                        child:  Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                          ),
                        ),
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