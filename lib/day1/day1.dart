import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

enum Direction {
  start,
  end,
}

Map<String, int> spelledNumberMap = {
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
};

Map<String, String> brokenElements = {
  'oneight': 'oneeight',
  'fiveight': 'fiveeight',
  'nineight': 'nineeight',
  'threeight': 'threeeight',
  //t
  'eightwo': 'eighttwo',
  'eighthree': 'eightthree',
  //o
  'twone': 'twoone',
  //n
  'sevenine': 'sevennine',
};

void calcSumOfTextLine() async {
  final content = await File('./data/day1.txt').readAsString();
  LineSplitter ls = LineSplitter();
  final arrOfStrings = ls.convert(content);

  for (final (index, item) in arrOfStrings.indexed) {
    brokenElements.forEach((key, value) {
      arrOfStrings[index] = arrOfStrings[index].replaceAll(key, value);
    });
  }

  int acc = 0;

  for (var i = 0; i < arrOfStrings.length; i++) {
    final firstNumber = findNumberInString(arrOfStrings[i], Direction.start);
    final lastNumber = findNumberInString(arrOfStrings[i], Direction.end);
    int? numberToAdd = int.tryParse('$firstNumber$lastNumber');
    if (numberToAdd != null) {
      acc += numberToAdd;
    }
  }

  print(acc);
}

int? findNumberInString(String s, Direction direction) {
  final exp = RegExp(
      '(one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9)');
  Iterable<RegExpMatch> matches = exp.allMatches(s);
  List<RegExpMatch> matchesList = matches.toList();

  if (matchesList.isNotEmpty) {
    String? stringNumber = direction == Direction.start
        ? matchesList.first.group(0)
        : matchesList.last.group(0);

    return parseMatchToNumber(stringNumber);
  }

  return 0;
}

int? parseMatchToNumber(String? s) {
  if (s == null) {
    return null;
  }

  if (spelledNumberMap.containsKey(s)) {
    return spelledNumberMap[s];
  }

  return int.tryParse(s);
}
