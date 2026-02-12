// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medapp_frontend/doctor/providers/consultationmodel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends ConsumerWidget {
  final Consultationmodel consultation;
  ChatScreen({
    super.key,
    // in future make them all as required for testing purpose its hardcoded
    required this.consultation,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        //doctor name
        title: Text(
          consultation.doctor?.name ?? "Doctor",
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: (consultation.type == 'normal')
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
                            consultation.fullName,
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
                        'Date & Time:  ${DateFormat("dd MMM yyyy, hh:mm a").format(consultation.createdAt)}',
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
                        onTap:
                          consultation.patientFileUrl == null ? null:(){
                          final url =
                              "https://consultone-six3.onrender.com/${consultation.patientFileUrl}";
                          launchUrl(Uri.parse(url));
                          
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
              (consultation.status == "responded")
                  ? Container(
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
                                  child: Icon(
                                    Icons.healing,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Date & Time:  ${DateFormat("dd MMM yyyy, hh:mm a").format(consultation.createdAt)}',
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
                              onTap: consultation.patientFileUrl == null ? null: () {
                                final url =
                                    "https://consultone-six3.onrender.com/${consultation.doctorFileUrl}";
                                launchUrl(Uri.parse(url));
                              },
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color.fromARGB(
                                    255,
                                    235,
                                    235,
                                    235,
                                  ),
                                ),
                                child: Icon(Icons.remove_red_eye),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  //if no reply blank container
                  : Container(
                      height: 301,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          '❌ NO RESPONSE YET ❌',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30),
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
