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
//   final content = """Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
// Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
// Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
// Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
// Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green""";
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
      final roundValues = game.trim().split(',');

      for (final (index, roundValue) in roundValues.indexed) {
        final cubicMap = roundValue.trim().split(' ');

        gameRoundValues.update(cubicMap[1], (value) {
          int cubicCurrentValue = (int.tryParse(cubicMap[0]) ?? 0);
          if (value < cubicCurrentValue) {
            return cubicCurrentValue;
          }

          return value;
        });
      }

    }

    gamesSum += gameRoundValues['blue']! *
        gameRoundValues['red']! *
        gameRoundValues['green']!;

  }

  print(gamesSum);
}
