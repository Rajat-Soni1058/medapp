import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medapp_frontend/doctor/providers/consultationmodel.dart';
import 'package:medapp_frontend/patient/providers/patientrepo.dart';

final consultationByIdProvider =
    FutureProvider.family<Consultationmodel, String>((ref, id) async {
  final repo = Patientrepo();
  return repo.getconsult(id);
});

class ChatScreen extends ConsumerWidget {
  final String consultationId;

  const ChatScreen({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultationAsync =
        ref.watch(consultationByIdProvider(consultationId));

    return consultationAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text("Error: $e")),
      ),
      data: (consultation) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),

          // ✅ APP BAR FIXED
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            automaticallyImplyLeading: true,
            title: Text(
              consultation.doctor?.name ?? "Doctor",
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: consultation.type == 'normal'
                ? null
                : [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.video_call),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.call),
                    ),
                  ],
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // PATIENT FORM
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
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
                          const SizedBox(height: 10),

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

                          const SizedBox(height: 20),

                          Text(
                            'Date & Time: ${DateFormat("dd MMM yyyy, hh:mm a").format(consultation.createdAt)}',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Attached form:',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 10),

                          consultation.patientFileUrl != null &&
                                  consultation.patientFileUrl!.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    final uri =
                                        Uri.parse(consultation.patientFileUrl!);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode:
                                            LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      color: const Color.fromARGB(
                                          255, 235, 235, 235),
                                    ),
                                    child: const Icon(Icons.remove_red_eye),
                                  ),
                                )
                              : const Text(
                                  "No file attached",
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // DOCTOR RESPONSE
                  consultation.status == "responded"
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3, color: Colors.green),
                            borderRadius:
                                BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  "Doctor Responded",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                consultation.doctorFileUrl != null &&
                                        consultation
                                            .doctorFileUrl!.isNotEmpty
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          final uri = Uri.parse(
                                              consultation
                                                  .doctorFileUrl!);
                                          if (await canLaunchUrl(
                                              uri)) {
                                            await launchUrl(
                                              uri,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                        child: const Text(
                                            "View Doctor Attachment"),
                                      )
                                    : const Text(
                                        "No attachment from doctor"),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.red),
                            borderRadius:
                                BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              '❌ NO RESPONSE YET ❌',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
