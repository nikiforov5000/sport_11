import 'dart:async';

import 'package:flutter/foundation.dart';

class GameTimer {
  static bool isRunning = false;
  static Timer? _timer;
  static const int _gameDuration = 200;
  static int _timeLeft = _gameDuration;
  static bool gameOver = false;
  static final StreamController _controller = StreamController();
  static final StreamController<bool> _isRunningController = StreamController();

  static Stream<bool> isRunningStream = _isRunningController.stream;

  static restart() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timeLeft = _gameDuration;
    gameOver = false;
    isRunning = true;
    _controller.add(_timeLeft);
    startTimer();
  }

  ////////  TODO FINISH START / RESTART LOGIC

  static void startTimer() {
    _isRunningController.add(isRunning);
    const oneTenthOfSecond = Duration(milliseconds: 100);
    _timer = Timer.periodic(
      oneTenthOfSecond,
      (Timer timer) {
        if (kDebugMode) {
          // debugPrint('game_timer.dart -> timer:$_timeLeft');
        }
        if (_timeLeft < 1) {
          _controller.add(_timeLeft);
          _timer!.cancel();
          gameOver = true;
          _isRunningController.add(isRunning);
          isRunning = false;
        } else {
          _controller.add(_timeLeft);
          _timeLeft -= 1;
        }
      },
    );
  }

  static Stream get timeStream => _controller.stream;

  static String string() {
    String seconds = (_timeLeft / 10).floor().toString();
    String oneTenth = (_timeLeft % 10).toString();
    return 'Time left: $seconds.$oneTenth';
  }

  static percentLeft() {
    return (_gameDuration - _timeLeft) / _gameDuration;
  }
}
