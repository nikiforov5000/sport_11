import 'dart:math';

class FrontImage {
  final Random _random = Random();
  final List<bool> _visited = List.generate(16, (index) => false);

  final Map<int, String> _imagePaths = {
    0: 'assets/images/cards/front/whistle.jpg',
    1: 'assets/images/cards/front/badminton.jpg',
    2: 'assets/images/cards/front/baseball.jpg',
    3: 'assets/images/cards/front/basketball.jpg',
    4: 'assets/images/cards/front/bowling.jpg',
    5: 'assets/images/cards/front/cup.jpg',
    6: 'assets/images/cards/front/dart.jpg',
    7: 'assets/images/cards/front/football.jpg',
    8: 'assets/images/cards/front/golf.jpg',
    9: 'assets/images/cards/front/medal.jpg',
    10: 'assets/images/cards/front/podium.jpg',
    11: 'assets/images/cards/front/pull.jpg',
    12: 'assets/images/cards/front/shoe.jpg',
    13: 'assets/images/cards/front/tennis.jpg',
    14: 'assets/images/cards/front/us-football.jpg',
    15: 'assets/images/cards/front/volley.jpg',
  };

  String getRandomFrontImage() {
    int index = _random.nextInt(16);
    while (_visited[index]) {
      index = _random.nextInt(16);
    }
    _visited[index] = true;
    return _imagePaths[index] ?? '';
  }
}