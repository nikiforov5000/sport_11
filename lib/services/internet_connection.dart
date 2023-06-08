import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class InternetConnection {
  bool _prevStatus = true;
  bool _currentStatus = false;
  
  final StreamController<bool> _internetStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get internetStatusStream => _internetStatusController.stream;

  InternetConnection() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        _checkInternetConnection();
      },
    );
  }

  Future<void> _checkInternetConnection() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      _currentStatus = response.statusCode == 200;
      debugPrint('_prevStatus:$_prevStatus');
      debugPrint('currentStatus:$_currentStatus');
    } catch (e) {
      debugPrint(e.toString());
      _currentStatus = false;
    }
    if (_prevStatus != (_currentStatus)) {
      _internetStatusController.add(_currentStatus);
      _prevStatus = _currentStatus;
    }
  }

  void dispose() {
    _internetStatusController.close();
  }
}
