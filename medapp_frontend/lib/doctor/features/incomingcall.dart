import 'package:flutter/material.dart';
import 'package:medapp_frontend/patient/features/video_call_screen.dart';
import 'package:medapp_frontend/services/tokenstorage.dart';

class IncomingCallDialog extends StatelessWidget {
  final String callId;
  final String patientName;

  const IncomingCallDialog({
    super.key,
    required this.callId,
    required this.patientName,
  });

  static void show(BuildContext context, String callId, String patientName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => IncomingCallDialog(
        callId: callId,
        patientName: patientName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Incoming Video Call'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.video_call, size: 60, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            patientName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('is calling you...'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Reject call
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Decline'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context); // Close dialog
            
            // Get doctor info
            final userId = await TokenStorage.getUserId() ?? 'doctor';
            final userName = await TokenStorage.getUserName() ?? 'Doctor';
            
            // Navigate to video call
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCallScreen(
                  callId: callId,
                  userId: userId,
                  userName: userName,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('Accept'),
        ),
      ],
    );
  }
}