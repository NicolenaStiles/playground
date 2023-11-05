// First set of problems for AOC Day 1
import 'dart:io';
import 'dart:math';

void firstFunction() {
    var calories = File('calories');

    List<String> lines = calories.readAsLinesSync();
    List<int> sums = [];

    int currSum = 0;
    for (var line in lines) {
        if (line == "") {
            sums.add(currSum);
            currSum = 0;
        } else {
            currSum = currSum + int.parse(line);
        }
    }

    print("The most calories carried by a single elf is ${sums.reduce(max)}");

    sums.sort();

    print("The top 3 most calories are:");
    print("1: ${sums[sums.length-1]}");
    print("2: ${sums[sums.length-2]}");
    print("3: ${sums[sums.length-3]}");


    int topThreeTotal = sums[sums.length-1] + 
                        sums[sums.length-2] + 
                        sums[sums.length-3];
    print("Total calories: $topThreeTotal");
}
