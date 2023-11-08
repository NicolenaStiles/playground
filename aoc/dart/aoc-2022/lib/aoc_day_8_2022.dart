import 'dart:io';

void partOne() {
    // load from file
    var inputTest = File('input-day-8-test');
    var inputFile = File('input-day-8');

    bool isDebug = true;
    List<String> readIn = [];
    if (isDebug) {
        readIn = inputTest.readAsLinesSync();
    } else {
       readIn = inputFile.readAsLinesSync();
    }

    // treeHeights tracks the heights of the trees
   List<List<int>> treeHeights = [];
   for (var treeline in readIn) {
       List<int> heights = treeline.split("").map((e) => int.parse(e)).toList();
       treeHeights.add(heights);
   }
    // isVisible tracks if the trees are visible from outside the grid
    List<bool> temp = List.generate(readIn[0].length, (index) => false);
    List<List<bool>> isVisible = List.generate(readIn.length, (index) => temp);

    for (var entry in isVisible) {
        print(entry);
    }

    // figure out if taller in any direction
    for (int y = 1; y < treeHeights[0].length - 1; y++) {
        for (int x = 1; x < treeHeights.length - 1; x++) {
            int currHeight = treeHeights[y][x];
            print("flipped: $x,$y:${treeHeights[y][x]}");
            // checking the north
            bool visibleNorth = true;
            for (int numNorth = 0; numNorth < y; numNorth++) {
                if (currHeight < treeHeights[numNorth][x]) {
                    visibleNorth = false;
                }
            }
            // checking the south 
            bool visibleSouth = true;
            for (int numSouth = y + 1; numSouth < treeHeights.length - 2; numSouth++) {
                if (currHeight < treeHeights[numSouth][x]) {
                    visibleSouth = false;
                }
            }
            // checking the west 
            bool visibleWest = true;
            for (int numWest = 0; numWest < x; numWest++) {
                if (currHeight < treeHeights[y][numWest]) {
                    visibleWest = false;
                }
            }
            // checking the east 
            bool visibleEast = true;
            for (int numEast = x + 1; numEast < treeHeights[0].length - 2; numEast++) {
                if (currHeight < treeHeights[y][numEast]) {
                    visibleEast = false;
                }
            }
            if (visibleNorth || visibleSouth || visibleEast || visibleWest) {
                isVisible[y][x] = true;
            }
        }
    }
    for (var entry in isVisible) {
        print(entry);
    }
    for (var treeline in treeHeights) {
        print(treeline);
    }
}
