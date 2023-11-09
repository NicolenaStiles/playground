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
    List<List<bool>> isVisible = []; 
    for (int y = 0; y < readIn.length; y++) {
        List<bool> temp = []; 
        for (int x = 0; x < readIn[0].length; x++) {
            temp.add(false);
        }
        isVisible.add(temp);
    }

    // make sure the outside edge is marked as visible
    for (int y = 0; y < treeHeights[0].length; y++) {
        for (int x = 0; x < treeHeights.length; x++) {
            if (y == 0 || x == 0) {
                isVisible[y][x] = true;
            } else if (y == treeHeights[0].length - 1 || x == treeHeights.length - 1) {
                isVisible[y][x] = true;
            }
        }
    }

    // figure out if taller in any direction
    for (int y = 1; y < treeHeights[0].length - 1; y++) {
        for (int x = 1; x < treeHeights.length - 1; x++) {
            int currHeight = treeHeights[y][x];
            // checking the north
            bool visibleNorth = true;
            for (int numNorth = 0; numNorth < y; numNorth++) {
                if (currHeight <= treeHeights[numNorth][x]) {
                    visibleNorth = false;
                }
            }
            // checking the south 
            bool visibleSouth = true;
            for (int numSouth = y + 1; numSouth < treeHeights.length; numSouth++) {
                if (currHeight <= treeHeights[numSouth][x]) {
                    visibleSouth = false;
                }
            }
            // checking the west 
            bool visibleWest = true;
            for (int numWest = 0; numWest < x; numWest++) {
                if (currHeight <= treeHeights[y][numWest]) {
                    visibleWest = false;
                }
            }
            // checking the east 
            bool visibleEast = true;
            for (int numEast = x + 1; numEast < treeHeights[0].length; numEast++) {
                if (currHeight <= treeHeights[y][numEast]) {
                    visibleEast = false;
                }
            }
            if (visibleNorth || visibleSouth || visibleEast || visibleWest) {
                isVisible[y][x] = true;
            }
        }
    }

    // get total number of visible trees
    int numVisible = 0;
    for (int y = 0; y < treeHeights[0].length; y++) {
        for (int x = 0; x < treeHeights.length; x++) {
            if (isVisible[y][x]) {
                numVisible++;
            }
        }
    }
    print(numVisible);
}
