import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  static const String id = '/web_view_screen';
  final String _url;

  WebViewScreen(this._url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('WebViewScreen()'),
    );
  }
}

