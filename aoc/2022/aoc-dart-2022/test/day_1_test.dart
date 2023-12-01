import 'package:test/test.dart';
import 'package:aoc_dart_2022/common/common.dart';
import 'package:aoc_dart_2022/day_1.dart';

void main() {

  test('day-1-part-1-logic', () {

    List<String> lines = read_in_file('../input/day_1/test');
    
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

    expect(sums.last, 24000);

  });

  test('day-1-part-1-impl', () {
    expect(partOne('../input/day_1/test'), 24000);
  });

  test('day-1-part-2-logic', () {

    List<String> lines = read_in_file('../input/day_1/test');
    
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

    int topThreeTotal = sums[sums.length-1] +
                        sums[sums.length-2] +
                        sums[sums.length-3]; 

    expect(topThreeTotal, 45000);

  });

  test('day-1-part-2-impl', () {
    expect(partTwo('../input/day_1/test'), 45000);
  });

}
