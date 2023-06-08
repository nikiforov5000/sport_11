
import 'package:flutter/material.dart';
import 'package:sport_11/constants/text_styles.dart';
import 'package:sport_11/models/game_timer.dart';
import 'package:sport_11/widgets/progress_bar.dart';

class GameTimerWidget extends StatelessWidget {
  const GameTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GameTimer.timeStream,
      builder: (BuildContext context, snapshot) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ProgressBar(value: GameTimer.percentLeft()),
            GameTimer.gameOver ? GameOverTitle() : TimerTitle(),
          ],
        );
      },
    );
  }
}

class TimerTitle extends StatelessWidget {
  const TimerTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      GameTimer.string(),
      style: kProgressBarTextStyle,
    );
  }
}

class GameOverTitle extends StatelessWidget {
  GameOverTitle({Key? key}) : super(key: key);

  String gameOverString = 'Game Over';

  @override
  Widget build(BuildContext context) {
    return Text(
      gameOverString,
      style: kProgressBarTextStyle,
    );
  }
}
