import 'dart:io';

void partOne() {
    // load from file
    var inputTest = File('input-day-8-test');
    var inputFile = File('input-day-8');

    bool isDebug = false;
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

void partTwo() {

    // load from file
    var inputTest = File('input-day-8-test');
    var inputFile = File('input-day-8');

    bool isDebug = false;
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
    
    // scenicScore tracks the scenic score from each location
    List<List<int>> scenicScore = []; 
    for (int y = 0; y < readIn.length; y++) {
        List<int> temp = []; 
        for (int x = 0; x < readIn[0].length; x++) {
            temp.add(0);
        }
        scenicScore.add(temp);
    }

    // scenic score calculation
    for (int y = 0; y < treeHeights[0].length; y++) {
        for (int x = 0; x < treeHeights.length; x++) {
            int currHeight = treeHeights[y][x];
            List<int> currScore = [];
            // checking the north
            // only check if not on the upper edge
            int northScore = 0;
            if (y != 0) {
                for(int numNorth = y - 1; numNorth >= 0; numNorth--) {
                    if (currHeight > treeHeights[numNorth][x]) {
                        northScore++;
                    } else if (currHeight <= treeHeights[numNorth][x]) {
                        northScore++;
                        break;
                    } else {
                        break;
                    }
                }
                currScore.add(northScore);
            } else {
                currScore.add(northScore);
            }
            // checking the south
            // only check if not on the lower edge
            int southScore = 0;
            if (y != treeHeights.length - 1) {
                for(int numSouth = y + 1; numSouth < treeHeights.length; numSouth++) {
                    if (currHeight > treeHeights[numSouth][x]) {
                        southScore++;
                    } else if (currHeight <= treeHeights[numSouth][x]) {
                        southScore++;
                        break;
                    } else {
                        break;
                    }
                }
                currScore.add(southScore);
            } else {
                currScore.add(southScore);
            }
            // checking the west
            // only check if not on the left edge
            int westScore = 0;
            if (x != 0) {
                for(int numWest = x - 1; numWest >= 0; numWest--) {
                    if (currHeight > treeHeights[y][numWest] ) {
                        westScore++;
                    } else if (currHeight <= treeHeights[y][numWest] ) {
                        westScore++;
                        break;
                    } else {
                        break;
                    }
                }
                currScore.add(westScore);
            } else {
                currScore.add(westScore);
            }
            // checking the east
            // only check if not on the left edge
            int eastScore = 0;
            if (x != treeHeights[0].length - 1) {
                for(int numEast = x + 1; numEast < treeHeights[0].length; numEast++) {
                    if (currHeight > treeHeights[y][numEast] ) {
                        eastScore++;
                    } else if (currHeight <= treeHeights[y][numEast] ) {
                        eastScore++;
                        break;
                    } else {
                        break;
                    }
                }
                currScore.add(eastScore);
            } else {
                currScore.add(eastScore);
            }
            scenicScore[y][x] = currScore.fold(1, (p,c) => p * c);
        }
    }

    // finding max scenic score
    int maxScenicScore = 0;
    for (int y = 0; y < scenicScore[0].length; y++) {
        for (int x = 0; x < scenicScore.length; x++) {
            if (scenicScore[y][x] > maxScenicScore) {
                maxScenicScore = scenicScore[y][x];
            }
        }
    }
    print(maxScenicScore);
}
