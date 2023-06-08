import 'dart:async';

import 'package:sport_11/models/flipping_card.dart';
import 'package:sport_11/models/front_image.dart';
import 'package:sport_11/models/game_timer.dart';


class GameController {
  static final List<FlippingCard> _list = [];

  static int _prev = -1;

  static int cardsQuantity = 16;

  static int solved = 0;

  static StreamController<double> scoreController = StreamController();

  static get scores => solved / cardsQuantity;

  static get scoresStream => scoreController.stream;

  static get list => _list;

  static bool get noPrevCard => _prev == -1;

  static restart() {
    GameTimer.restart();
    solved = 0;
    scoreController.add(scores);
    seedCardList();
    resetPrev();
  }

  static void seedCardList() {
    FrontImage frontImage = FrontImage();

    _list.clear();
    for (int i = 0; i < cardsQuantity / 2; ++i) {
      String imgPath = frontImage.getRandomFrontImage();
      _list.add(FlippingCard(imagePath: imgPath, label: i + 1));
      _list.add(FlippingCard(imagePath: imgPath, label: i + 1));
    }
    _list.shuffle();
  }

  static void flipCard(int index) {
    if (!GameTimer.isRunning) {
      GameTimer.startTimer();
      GameTimer.isRunning = true;
    }
    _list[index].isFlipped = true;
  }

  static void setPrev(int index) {
    _prev = index;
  }

  static bool isMatch(int index) {
    return _list[index].label == _list[_prev].label;
  }

  static void resetPrev() {
    _prev = -1;
  }

  static void markCardsAsMatched(int index) {
    solved += 2;
    scoreController.add(scores);
    _list[index].isMatched = true;
    _list[_prev].isMatched = true;
  }

  static void flipCardsBack(int index) {
    for (FlippingCard card in _list) {
      if (card.isMatched == false) {
        card.isFlipped = false;
      }
    }
    resetPrev();
  }

  static bool isNotClickable(int index) {
    return index == _prev || _list[index].isFlipped || _list[index].isMatched;
  }

  static bool isTappedMoreThanTwo() {
    if (_prev != -1 && flippedButNotMatched()) {
      return true;
    }
    return false;
  }

  static bool flippedButNotMatched() {
    int count = 0;
    for (FlippingCard card in _list) {
      if (!card.isMatched && card.isFlipped) {
        if (++count == 2) {
          return true;
        }
      }
    }
    return false;
  }
}
