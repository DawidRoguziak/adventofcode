import 'dart:convert';
import 'dart:io';

class Card {
  int cardIndex;
  List<int> winningNumbers = [];
  List<int> cardNumbers = [];

  Card(this.cardIndex, this.winningNumbers, this.cardNumbers);

  int getWinningPointsSum() {
    int sum = 0;

    for (int i = 0; i < winningNumbers.length; i++) {
      for (int j = 0; j < cardNumbers.length; j++) {
        if (winningNumbers[i] == cardNumbers[j]) {
          sum = (sum == 0 ? 1 : sum * 2);
        }
      }
    }

    return sum;
  }

  int getWinningMatches() {
    int count = 0;
    for (int i = 0; i < winningNumbers.length; i++) {
      for (int j = 0; j < cardNumbers.length; j++) {
        if (winningNumbers[i] == cardNumbers[j]) {
          ++count;
        }
      }
    }

    return count;
  }
}

int taskOne = 0;
int taskTwo = 0;
List<Card> arrayOfCards = [];

Map<int, int> tmpCardMap = {};

void day4() async {
  final content = await File('./data/day4.txt').readAsString();
  LineSplitter ls = LineSplitter();
  final arrOfString = ls.convert(content);

  for (final (index, element) in arrOfString.indexed) {
    Card card = parseRow(index, element);
    arrayOfCards.add(card);
    // taskOne += card.getWinningPointsSum();
  }

  checkCards(0, arrayOfCards.length - 1);

  taskTwo = tmpCardMap.values.reduce((value, element) => value + element);


  print(taskTwo);
}

void checkCards(int start, int end) {

  for (int i = start; i <= end; i++) {
    // print(i);
    //
    tmpCardMap.putIfAbsent(arrayOfCards[i].cardIndex, () => 0);
    tmpCardMap.update(arrayOfCards[i].cardIndex, (value) => value + 1);
    //

    // add current points
    int counter = arrayOfCards[i].getWinningMatches();

    if (counter != 0) {
      checkCards(i + 1, i + counter);
    }

  }
}

Card parseRow(int cardIndex, String row) {
  List<String> rowSplit = row.split(':');
  String numbersInCard = rowSplit[1];

  List<String> numbersType = numbersInCard.split('|');

  List<int> winningNumbers = parseNumbers(numbersType[0]);
  List<int> cardNumbers = parseNumbers(numbersType[1]);

  return Card(cardIndex, winningNumbers, cardNumbers);
}

List<int> parseNumbers(String numbers) {
  return numbers
      .trim()
      .split(RegExp(r'\s+')) // split numbers
      .map((e) {
    // convert to integer
    int? num = int.tryParse(e);
    return num ?? 0;
  }).toList();
}

void printTmpCardMap() {
  for (var entry in tmpCardMap.entries) {
    print('${entry.key}: ${entry.value}');
  }
}
