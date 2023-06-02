import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Wrapper.id,
    );
  }
}

class Wrapper extends StatelessWidget {
  static const String id = '/check_link';
  
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (checklsEmu() == true) {
      return PlayScreen();
    }
    else {
      return WebViewScreen();
    }

    return const Placeholder();
  }
}


