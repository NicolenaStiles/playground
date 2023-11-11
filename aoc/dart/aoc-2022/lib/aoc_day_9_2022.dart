import 'dart:io';
import 'dart:math';

// reads input and returns list of list of strings
// for each line, idx represents:
// 0: direction for movement
// 1: repetions of movement
List<List> readInput(String filename){
    List<List> movements = [];
    List<String> readIn  = File(filename).readAsLinesSync();
    for(var c in readIn) {
        movements.add([c.split(" ")[0] , int.parse(c.split(" ")[1])]);
    }
    return movements;
}

List<int> getBounds(List<List> movements) {
    int maxX = 0;
    int maxY = 0;
    int minX = 0;
    int minY = 0;
    int currX = 0;
    int currY = 0;
    List<int> bounds = [];
    for (var m in movements) {
        int val = m[1];
        switch (m[0]) {
            case 'U':
                currY = currY + val;
                if (currY > maxY) {
                    maxY = currY;
                }
            break;
            case 'D':
                currY = currY - val;
                if (currY < minY) {
                    minY = currY;
                }
            break;
            case 'L':
                currX = currX - val;
                if (currX < minX) {
                    minX = currX;
                }
            break;
            case 'R':
                currX = currX + val;
                if (currX > maxX) {
                    maxX = currX;
                }
            break;
          default:
        }
    }
    bounds = [minX,minY,maxX,maxY];
    int lowerBound = bounds.reduce(min);
    int upperBound = bounds.reduce(max);
    bounds = [lowerBound,upperBound];
    print('Lower: $lowerBound, Upper: $upperBound');
    return bounds;
}

void drawKnots(int bound, List<List<int>> pos, List<String> name) {

    List<List<String>> printPos = [];
    for(int i = 0; i < bound; i++) {
        printPos.add(List<String>.generate(bound, (e) => '.', growable: true));
    } 

    for (int i = 0; i < name.length; i++) {
        String n = name[i];
        int currPosX = pos[i][0];
        int currPosY = pos[i][1];
        printPos[currPosX][currPosY] = n;
    }

    for (var l in printPos.reversed.toList()) {
        print(l.join());
    }
}

// move head and return new position
List<int> moveHead(String move, List<int> position) {
    List<int> currentHead = position;
        switch (move) {
            case 'U': 
                currentHead[1]++;
                break;

            case 'D': 
                currentHead[1]--;
                break;

            case 'L': 
                currentHead[0]--;
                break;

            case 'R': 
                currentHead[0]++;
                break;

            default:
                print("ERROR reading movement direction!");
        } 
    return currentHead;
}

// move follower closer to head
List<int> moveFollower(List<int> head, List<int> tail) {

    List<int> currentTail = tail;
    int diffX = head[0] - tail[0];
    int diffY = head[1] - tail[1];

    if(diffX.abs() > 1) {
        if(diffX > 0) {
            currentTail[0]++;
        } else {
            currentTail[0]--;
        }
        if(diffY != 0) {
            if(diffY > 0) {
                currentTail[1]++;
            } else {
                currentTail[1]--;
            }
        }
    }

    if(diffY.abs() > 1) {
        if(diffY > 0) {
            currentTail[1]++;
        } else {
            currentTail[1]--;
        }
        if(diffX != 0) {
            if(diffX > 0) {
                currentTail[0]--;
            } else {
                currentTail[0]++;
            }
        }
    }

    return currentTail;

}

void partOne() {

    // reading in data as usual
    List<List> movements = readInput('input-day-9');

    // for real this time
    List<int> currHead = [0,0];
    List<int> currTail = [0,0];
    Set pathsHead = {};
    Set pathsTail= {};
    pathsHead.add("0,0");
    pathsTail.add("0,0");

    for(var move in movements) {
        for(int i = 0; i < move[1]; i++) {
            currHead = moveHead(move[0], currHead);
            currTail = moveFollower(currHead, currTail);
            String headPath = "${currHead[0]},${currHead[1]}";
            pathsHead.add(headPath);
            String tailPath = "${currTail[0]},${currTail[1]}";
            pathsTail.add(tailPath);
        }
    }

   print(pathsTail.length);

}
