import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

Future<void> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final RemoteConfigSettings remoteConfigSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(minutes: 1),
  );

  final defaultParameters = <String, dynamic>{
    'url': 'www.youtube.com',
  };

  try {
    await remoteConfig.setConfigSettings(remoteConfigSettings);
    // await remoteConfig.setDefaults(defaultParameters);
    await remoteConfig.fetchAndActivate();
  }
  catch (e) {
    debugPrint('remote_config.dart -> error:$e');
  }
}