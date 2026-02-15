import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class ConsultAi extends StatefulWidget {
  const ConsultAi({super.key});

  @override
  State<ConsultAi> createState() => _ConsultAiState();
}

class _ConsultAiState extends State<ConsultAi> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onWebResourceError: (err){
                debugPrint('WebView Error: $err');
              }
            )
          );
         _loadHtmlFromAssets();
  }

  void _loadHtmlFromAssets() async{
    try{
      final String fileHtmlContents = await rootBundle.loadString('assets/consultAi/consultAi.html');
      _webViewController.loadHtmlString(fileHtmlContents);
    }catch(e){
      debugPrint('failed to load asset : $e');
    }

  }

  @override
  void dispose() {
    _webViewController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: SizedBox(
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}