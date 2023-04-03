import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BeasiswaWebViewScreen extends StatefulWidget {
  const BeasiswaWebViewScreen({Key? key}) : super(key: key);

  @override
  State<BeasiswaWebViewScreen> createState() => _BeasiswaWebViewScreenState();
}

class _BeasiswaWebViewScreenState extends State<BeasiswaWebViewScreen> {
  WebViewController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://kemahasiswaan.itb.ac.id'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003A6E),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Web Kemahasiswaan ITB'),
      ),
      body: WebViewWidget(
        controller: _controller!,
      ),
    );
  }
}
