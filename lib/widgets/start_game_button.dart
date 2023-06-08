
import 'package:flutter/material.dart';
import 'package:sport_11/controllers/game_controller.dart';
import 'package:sport_11/models/game_timer.dart';

class StartGameButton extends StatefulWidget {
  const StartGameButton({Key? key}) : super(key: key);

  @override
  State<StartGameButton> createState() => _StartGameButtonState();
}

class _StartGameButtonState extends State<StartGameButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          GameController.restart();
        });
      },
      child: StreamBuilder(
        stream: GameTimer.isRunningStream,
        builder: (BuildContext context, snapshot) {
          final bool? isRunning = snapshot.data;
          String label = '';
          if (isRunning != null && isRunning) {
            label = 'Restart Game';
          }
          else {
            label = 'Start Game';
          }
          return StartGameButtonContainer(label);
        },
      ),
    );
  }
}

class StartGameButtonContainer extends StatelessWidget {
  final String _label;
  StartGameButtonContainer(this._label,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF2C942),  // Start color
            Color(0xffffdd00),  // Start color
            Color(0xfffab00e),  // Start color
            Color(0xff3d2601),  // Start color
          ],
          stops: [0.0, 0.33, 0.66, 1.0],  // Defines the position of each color
        ),
        border: Border.all(
          color: Colors.brown,  // Border color
          width: 2,  // Border width
        ),
        borderRadius: BorderRadius.circular(12),  // Rounded corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),  // Shadow color
            spreadRadius: 5,  // Extends the shadow
            blurRadius: 7,  // Soften the shadow
            offset: const Offset(0, 3),  // Position of the shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          _label,
          style: const TextStyle(
            shadows: [
              Shadow(
                color: Colors.brown,
                offset: Offset(0, 5),
                blurRadius: 30,
              ),
            ],
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

