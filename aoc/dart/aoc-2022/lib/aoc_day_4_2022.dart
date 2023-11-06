import 'dart:io';

void partOne () {

    // load assignments from file
    var inputFile = File('input-day-4');
    List<String> assignments = inputFile.readAsLinesSync();
    
    // parse w/ regexp and apply wonky logic
    int overlapCount = 0;
    final re = RegExp(r'\D');
    for (var pair in assignments) {
        List<int> bounds = pair.split(re).map((e) => int.parse(e)).toList();
        int leftDiff = bounds[0] - bounds[2];
        int rightDiff = bounds[1] - bounds[3];
        if (leftDiff == 0 || rightDiff == 0 || leftDiff.isNegative != rightDiff.isNegative) {
            overlapCount++;
        }
    }
    print(overlapCount);
}

void partTwo() {
    // load assignments from file
    var inputFile = File('input-day-4');
    List<String> assignments = inputFile.readAsLinesSync();
    
    // parse w/ regexp and apply wonky logic
    int anyOverlapCount = 0;
    final re = RegExp(r'\D');
    for (var pair in assignments) {
        List<int> bounds = pair.split(re).map((e) => int.parse(e)).toList();
        if (bounds[2] >= bounds[0] && bounds[2] <= bounds[1]) {
            anyOverlapCount++;
        } else if (bounds[3] >= bounds[0] && bounds[2] <= bounds[1]) {
            anyOverlapCount++;
        }
    }
    print(anyOverlapCount);
}


