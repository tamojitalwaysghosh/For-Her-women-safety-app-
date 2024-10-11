import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/031f6124-d5a8-40b6-924c-88aadf831e17'));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1,
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 19, 1, 7),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
