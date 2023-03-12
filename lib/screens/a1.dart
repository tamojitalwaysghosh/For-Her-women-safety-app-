import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Blogs1Screen extends StatefulWidget {
  const Blogs1Screen({super.key});

  @override
  State<Blogs1Screen> createState() => _Blogs1ScreenState();
}

class _Blogs1ScreenState extends State<Blogs1Screen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(
        'https://emptynestblessed.com/2020/10/14/safety-tips-for-women/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety tips for women-I')),
      body: WebViewWidget(controller: controller),
    );
  }
}
