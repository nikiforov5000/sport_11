import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final RemoteConfigSettings remoteConfigSettings = RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 10),
    minimumFetchInterval: Duration(hours: 1),
  );

  final defaultParameters = <String, dynamic>{
    'url': 'www.youtube.com',
  };

  try {
    await remoteConfig.setConfigSettings(remoteConfigSettings);
    await remoteConfig.setDefaults(defaultParameters);
    await remoteConfig.fetchAndActivate();
  }
  catch (e) {
    /// show no_internet_screen
  }
}