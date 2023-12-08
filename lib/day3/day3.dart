import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

void day3() async {
  final content = await File('./data/day3.txt').readAsString();
  LineSplitter ls = LineSplitter();
  final arrOfString = ls.convert(content);
  List<List<String>> grid = [];

  for (final line in arrOfString) {
    grid.add([...line.split('')]);
  }

  int gridRowsCount = grid.length;
  int gridColLength = grid[0].length;

  int taskOne = 0;
  int taskTwo = 0;

  Map<Record, List<int>> gearMap = {};

  for (final (rowIndex, gridRow) in grid.indexed) {
    Set<Record> gears = {};
    int currentNumberInCol = 0;
    bool hasPart = false;

    // for (final (colIndex, colString) in gridRow.indexed) {
    for (var colIndex = 0; colIndex < (gridRow.length + 1); colIndex++) {
      // print("$colIndex  $colString  $numbeR");
      if (colIndex < gridColLength && int.tryParse(gridRow[colIndex]) != null) {
        int numbeR = int.tryParse(gridRow[colIndex]) ?? 0;
        currentNumberInCol = currentNumberInCol * 10 + numbeR;
        // print("$colIndex  $numbeR");
        // check if number is part of engine
        // if (!hasPart) {
        for (final rSq in [-1, 0, 1]) {
          for (final cSq in [-1, 0, 1]) {
            final rowPosition = rowIndex + rSq;
            final colPosition = colIndex + cSq;
            if (0 <= rowPosition &&
                rowPosition < gridRowsCount &&
                0 <= colPosition &&
                colPosition < gridColLength) {
              final parsedChar = int.tryParse(grid[rowPosition][colPosition]);
              if (parsedChar == null && grid[rowPosition][colPosition] != '.') {
                hasPart = true;
              }
              if (grid[rowPosition][colPosition] == '*') {
                gears.add((rowPosition, colPosition));
              }
            }
          }
        }
        // }
      } else if (0 < currentNumberInCol) {
        // print("$currentNumberInCol, $hasPart, $gridRowsCount");
        // if we have a number and number have a symbol
        if (hasPart) {
          taskOne += currentNumberInCol;
        }

        for (final gear in gears) {
          gearMap.putIfAbsent(gear, () => []);
          gearMap[gear]?.add(currentNumberInCol);
        }

        // print(gearMap);
        // reset
        currentNumberInCol = 0;
        hasPart = false;
        gears = {};
      }
    }
  }

  gearMap.forEach((key, value) {
    if (value.length == 2) {
      taskTwo += value[0] * value[1];
    }
  });

  print(taskTwo);

}
