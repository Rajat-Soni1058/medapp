import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  final String callId;
  final String userId;
  final String userName;

  const VideoCallScreen({
    super.key,
    required this.callId,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1559270462,
      appSign: "c5dd5bcb0ae86ee0aa5e8c436e2bff5fa0cd3c8fedc1f12cf7aa2af0c53ebf8f", 
      userID: userId,
      userName: userName,
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
          showSoundWavesInAudioMode: true,
        ),
    );
  }
}
