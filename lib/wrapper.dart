import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:sport_11/screens/no_internet_screen.dart';
import 'package:sport_11/screens/play_screen.dart';
import 'package:sport_11/screens/web_view_screen.dart';
import 'package:sport_11/services/checksum.dart';
import 'package:sport_11/services/remote_config.dart';


class Wrapper extends StatelessWidget {
  static const String id = '/check_link';

  bool? _isEmu;

  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    checkIsEmu().then((value) => _isEmu = value);
    // final String url = FirebaseRemoteConfig.instance.getString('url');
    // return WebViewScreen(url);
    if (_isEmu == null || _isEmu == true) {
      return PlayScreen();
    }
    else {
      final String url = FirebaseRemoteConfig.instance.getString('url');
      if (url == '') {
        return NoInternetScreen();
      }
    print('wrapper.dart -> url:$url');
      return WebViewScreen(url);
    }
  }
}
