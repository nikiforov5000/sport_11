import 'package:flutter/material.dart';
import 'package:sport_11/screens/play_screen/controllers/game_controller.dart';
import 'package:sport_11/screens/play_screen/widgets/cards_grid.dart';
import 'package:sport_11/screens/play_screen/widgets/game_timer_widget.dart';
import 'package:sport_11/screens/play_screen/widgets/score_progress.dart';
import 'package:sport_11/screens/play_screen/widgets/start_game_button.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key) {
    GameController.seedCardList();
  }

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        top: height / 4.5,
        bottom: height / 60,
        left: width / 60,
        right: width / 60,
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)),
      child: Column(
        children: [
          const GameTimerWidget(),
          SizedBox(
            height: height / 50,
          ),
          ScoreProgress(),
          SizedBox(
            height: height / 50,
          ),
          const Expanded(
            child: CardsGrid(),
          ),
          SizedBox(
            height: height / 50,
          ),
          const StartGameButton(),
        ],
      ),
    );
  }
}
