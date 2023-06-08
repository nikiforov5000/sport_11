import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  final StreamController<bool> _internetStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get internetStatusStream => _internetStatusController.stream;

  InternetConnection() {
    Timer.periodic(
      const Duration(seconds: 2),
      (Timer t) {
        Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
          _internetStatusController.add(result != ConnectivityResult.none);
        });
      },
    );
  }

  void dispose() {
    _internetStatusController.close();
  }
}
