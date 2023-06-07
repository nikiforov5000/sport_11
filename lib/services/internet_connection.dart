import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class InternetConnection {
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
      _internetStatusController.add(response.statusCode == 200);
    } catch (e) {
      debugPrint(e.toString());
      _internetStatusController.add(false);
    }
  }

  void dispose() {
    _internetStatusController.close();
  }
}
