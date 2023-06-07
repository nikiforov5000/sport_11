import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_11/screens/no_internet_screen.dart';
import 'package:sport_11/screens/play_screen.dart';
import 'package:sport_11/screens/web_view_screen.dart';
import 'package:sport_11/services/remote_config.dart';
import 'package:sport_11/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupRemoteConfig();
    return MaterialApp(
      initialRoute: Wrapper.id,
      routes: {
        Wrapper.id: (context) => Wrapper(),
        PlayScreen.id: (context) => PlayScreen(),
        WebViewScreen.id: (context) => WebViewScreen(''),
        NoInternetScreen.id: (context) => NoInternetScreen(),
      },
    );
  }
}
