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
  final webViewController = WebViewController()
    ..loadRequest(Uri.parse(
        'https://www.komoot.com/it-it/tour/1370054647/embed?profile=1&share_token=${constants.komootToken}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter WebView"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse(
              'https://www.komoot.com/it-it/tour/1370054647/embed?profile=1&share_token=${constants.komootToken}')),
        ),
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          if (!await launchUrl(Uri.parse(
              "https://www.komoot.com/it-it/tour/1370054647?ref=wtd&share_token=${constants.komootToken}"))) {
            throw Exception('Could not launch komoot');
          }
          return NavigationActionPolicy.CANCEL;
        },
      ),
    );
    //WebViewWidget(controller: webViewController));
  }
}
