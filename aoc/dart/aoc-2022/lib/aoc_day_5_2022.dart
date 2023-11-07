import 'dart:io';

class CrateLayout {
    List<List<String>> stacks = [];

    CrateLayout(int numStacks, List<String> rawBoxData) {
        for (int i = 0; i < numStacks; i++) {
            stacks.add([]);
        } 

        for (int r = (rawBoxData.length - 1); r >= 0; r--) {
            for (int i = 0; i < numStacks; i++ ) {
                String currEntry = rawBoxData[r][i * 4 + 1];
                if (currEntry != " "){
                    stacks[i].add(currEntry);
                }
            }

        } 
    }

    // Move a single crate at a time
    // [# of crates, from, to]
    void moveCrate(List<int> moves) {
       int stackFrom = moves[1] - 1;
       int stackTo = moves[2] - 1;
       for (int i = 1; i <= moves[0]; i++) {
           String temp = stacks[stackFrom].removeLast();
           stacks[stackTo].add(temp);
        }
    }

    // Move an entire stack of crates all at once
    // [# of crates, from, to]
    void moveCrates(List<int> moves) {
       int stackFrom = moves[1] - 1;
       int stackTo = moves[2] - 1;
       List<String> stackTemp = [];
       for (int i = 1; i <= moves[0]; i++) {
           String temp = stacks[stackFrom].removeLast();
           stackTemp.add(temp);
        }
        stacks[stackTo].addAll(stackTemp.reversed.toList());
    }
}

void partOneTwo() {

    // assumptions at the outset
    int boxDataEnd = 8;
    int moveDataStart = 10;
    int numStacks = 9;

    // load from file
    // boxData will contain data about crate layout
    // moveData will contain data about move instructions
    var inputFile = File('input-day-5');
    List<String> boxAndMoveData = inputFile.readAsLinesSync();
    List<String> boxData = boxAndMoveData.sublist(0,boxDataEnd);
    List<String> moveData = boxAndMoveData.sublist(moveDataStart, boxAndMoveData.length);

    // parse move data into lists of ints
    List<List<int>> moveInstructions = [];
    final re = RegExp(r'\D+');
    for (var instruct in moveData) {
        List<String> instructInts = instruct.split(re);
        instructInts.removeAt(0);
        List<int> moves = instructInts.map((e) => int.parse(e)).toList();
        moveInstructions.add(moves);
    } 

    // PART ONE
    // apply move instructions to the crates

    // use CrateLayout as base data structure for trackin'
    var crates = CrateLayout(numStacks, boxData);

    for (var entry in moveInstructions) {
        crates.moveCrate(entry);
    }

    // print crates on top of each at the end?
    String finalTops = "";
    for (var stack in crates.stacks) {
        finalTops += stack.last;
    }
    print(finalTops);

    // PART TWO
    var cratesTwo = CrateLayout(numStacks, boxData);

    for (var entry in moveInstructions) {
        cratesTwo.moveCrates(entry);
    }

    // print crates on top of each at the end?
    String finalTopsTwo = "";
    for (var stack in cratesTwo.stacks) {
        finalTopsTwo += stack.last;
    }
    print(finalTopsTwo);

}
