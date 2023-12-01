import 'package:aoc_dart_2022/common/common.dart';

int partOne (String inputFilepath) {
    List<String> lines = read_in_file(inputFilepath);
    
    List<int> sums = [];

    int currSum = 0;
    for (var line in lines) {
      if (line == "") {
        sums.add(currSum);
        currSum = 0;
      } else {
        currSum += int.parse(line);
      }
    }

    sums.add(currSum);

    sums.sort();

    return sums.last;
}

int partTwo (String inputFilepath) {

    List<String> lines = read_in_file(inputFilepath);
    
    List<int> sums = [];

    int currSum = 0;
    for (var line in lines) {
      if (line == "") {
        sums.add(currSum);
        currSum = 0;
      } else {
        currSum += int.parse(line);
      }
    }

    sums.add(currSum);

    sums.sort();

    return sums[sums.length-1] + sums[sums.length-2] + sums[sums.length-3]; 
}

