import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  static const String id = '/web_view_screen';
  final String _url;

  const WebViewScreen(this._url, {Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _webViewController;
  double progress = 0;

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('web_view_screen.dart -> build -> url:${widget._url}');
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPressed,
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget._url)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    javaScriptCanOpenWindowsAutomatically: true,
                  ),
                ),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
              progress < 1.0
                  ? Center(
                      child: CircularProgressIndicator(
                        value: progress,
                        color: Colors.red,
                        strokeWidth: 2,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
