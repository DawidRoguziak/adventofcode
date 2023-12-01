import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

enum Direction {
  start,
  end,
}

void calcSumOfTextLine() async {
  final content = await File('./data/day1.txt').readAsString();
  LineSplitter ls = LineSplitter();
  final arrOfStrings = ls.convert(content);

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
  final chars = s.split('');

  int? foundedIndex;
  int i = direction == Direction.start ? 0 : chars.length - 1;
  final int end = direction == Direction.start ? chars.length : -1;

  do {
    var isElementNumber = int.tryParse(chars[i]);
    if (isElementNumber != null) {
      foundedIndex = isElementNumber;
      break;
    }

    if (direction == Direction.start) {
      ++i;
    } else {
      --i;
    }
  } while (i != end);

  return foundedIndex;
}
