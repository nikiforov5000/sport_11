import 'package:flutter/material.dart';
import 'package:sport_11/screens/play_screen/screens/game_screen.dart';

class PlayScreen extends StatelessWidget {
  static const String id = '/play_screen';

  const PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameScreen());
  }
}



