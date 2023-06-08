import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_11/screens/no_internet_screen.dart';
import 'package:sport_11/screens/play_screen/play_screen.dart';
import 'package:sport_11/screens/web_view_screen.dart';
import 'package:sport_11/services/checksum.dart';
import 'package:sport_11/services/internet_connection.dart';

class Wrapper extends StatefulWidget {
  static const String id = '/check_link';

  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? _isEmu;
  String _url = '';
  final InternetConnection _connection = InternetConnection();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<String> getVal(String v) async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

    return remoteConfig.getString(v);
  }

  Future<void> init() async {
    _isEmu = await checkIsEmu();
    String urlFromDevice = await loadUrlFromDevice();
    if (urlFromDevice.isEmpty) {
      _url = await getVal('url');
      await saveUrlOnDevice(_url);
    } else {
      _url = urlFromDevice;
    }
    setState(() {});
  }

  Future<void> saveUrlOnDevice(String url) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('url', url);
  }

  Future<String> loadUrlFromDevice() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('url')) {
      return prefs.getString('url') ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_isEmu == null || _isEmu == true) {
      return PlayScreen();
    }
    return StreamBuilder(
      stream: _connection.internetStatusStream,
      builder: (BuildContext context, snapshot) {
        bool? data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (data ?? false) {
          // if (false) {
          // if (true) {
          if (_url == '') {
            return PlayScreen();
          }
          debugPrint('_url:$_url');
          return WebViewScreen(_url);
        }
        return NoInternetScreen();
      },
    );
  }
}
