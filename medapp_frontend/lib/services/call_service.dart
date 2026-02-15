import 'package:url_launcher/url_launcher.dart';

class CallService {
  static Future<void> openDialer(String phoneNumber) async {
    final Uri dialUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if(await canLaunchUrl(dialUri)){
      await launchUrl(dialUri);
    }else{
      throw 'could not open dialer';
    }
  }
}