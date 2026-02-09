import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  final String caseType;
  final String doctorName;
  final String patientName;
  final bool isReplied;
  //final DateTime datetime;
  //final patient form
  //final doctor prescription
  const ChatScreen({
    super.key,
    // in future make them all as required for testing purpose its hardcoded
    this.caseType = "normal",
    this.doctorName = "Dr.Name",
    this.patientName = "Kumar Sahil",
     this.isReplied = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        //doctor name
        title: Text(
          doctorName,
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: (caseType == 'normal')
            ? null
            : [
                IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //patient form
              Container(
                // height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Form',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Patient Name: ",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            patientName,
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Date & Time:  ${DateTime.now()}',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Attached form: ',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          //form open
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 235, 235, 235),
                          ),
                          child: Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              //Doctors'prescription
              (isReplied == true)?
              Container(
                // height: 301,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Doctor's Prescription",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Digital Prescription",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.green.withOpacity(0.5),
                            ),
                            child: Icon(Icons.healing, color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Date & Time:  ${DateTime.now()}',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Attached file: ',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          //file open
                        },
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 235, 235, 235),
                          ),
                          child: Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              //if no reply blank container
              :Container(
                height: 301,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text('❌ NO RESPONSE YET ❌',style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () {
                    //future rebook function
                  },
                
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Rebook',
                      style: GoogleFonts.bungee(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
