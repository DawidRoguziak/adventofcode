import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

Map<String, int> maxes = {
  'blue': 14,
  'red': 12,
  'green': 13,
};

int gamesSum = 0;

void day2() async {
  final content = await File('./data/day2.txt').readAsString();
  LineSplitter ls = LineSplitter();
  final arrOfGames = ls.convert(content);

  for (final gameFromInput in arrOfGames) {
    final gameAndCubes = gameFromInput.split(':');
    final gameNumber = gameAndCubes[0].split(' ')[1];

    final gameRounds = gameAndCubes[1].split(';');

    Map<String, int> gameRoundValues = {
      'blue': 0,
      'red': 0,
      'green': 0,
    };

    for (final (index, game) in gameRounds.indexed) {
      final roundValues = game.split(',');
      for (final (index, roundValue) in roundValues.indexed) {
        final cubicMap = roundValue.trim().split(' ');
        print(cubicMap);
        gameRoundValues.update(
            cubicMap[1], (value) => value + (int.tryParse(cubicMap[0]) ?? 0));
      }
    }
    // print(gameRoundValues);
    bool equals = true;
    for (final max in maxes.entries) {
      // print(max.value);
      // print(gameRoundValues[max.key]);
      if (max.value < gameRoundValues[max.key]!) {
        equals = false;
        break;
      }
    }

    // print(equals);
    if (equals) {
      gamesSum += (int.tryParse(gameNumber) ?? 0);
    }
    break;
  }

  print(gamesSum);
}
