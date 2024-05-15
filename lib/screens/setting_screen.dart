import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helpers/constants.dart' as constants;

class SettingScreen extends StatefulWidget {
  final Color bgColor;

  const SettingScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter WebView"),
      )
    );
    //WebViewWidget(controller: webViewController));
  }
}
