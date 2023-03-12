import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Blogs3Screen extends StatefulWidget {
  const Blogs3Screen({super.key});

  @override
  State<Blogs3Screen> createState() => _Blogs3ScreenState();
}

class _Blogs3ScreenState extends State<Blogs3Screen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(
        'https://timesofindia.indiatimes.com/blogs/the-next-step/safety-tips-for-women/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety tips for women-III')),
      body: WebViewWidget(controller: controller),
    );
  }
}
