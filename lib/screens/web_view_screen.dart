import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const String id = '/web_view_screen';
  final String _url;

  WebViewScreen(this._url, {Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initiateWebView();
  }

  void initiateWebView() {
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00112233))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Webview is loading: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('Page startet loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resorce error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        )
      )
      ..loadRequest(Uri.parse(widget._url));

  }

  late InAppWebViewController _webViewController;
  late PullToRefreshController _pullToRefreshController;
  double progress = 0;

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return false;
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('web_view_screen.dart -> build');
    return Scaffold(
      body: WillPopScope(
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
    );
  }
}
