import 'dart:io';

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

// Executes a single move instruction for n knots.
// inputs:
// String move: string indicating which move is to be executed (U,D,L,R);
// List<List<int>> position: list (length n) of positions (x,y) for n knots
// output:
//
void singleMove(String move, List<List<int>> position) {

}

// reads in a list of movements and applies them based on current head/tail pos
// inputs:
// moves[0] == U,D,L,R, moves[1] == # movements (as int)
// head[0] == x, head[1] == y
// tail[0] == x, tail[1] == y
// outputs:
// Map (with keys 'H' and 'T') of List<List<int>>, where each list 
// represents coordinates after a single move
Map executeMoves(List moves, List<int> head, List<int> tail) {
    Map path = {};
    path['H'] = [];
    path['T'] = [];
    List<int> headPos = head;
    List<int> tailPos = tail;
    for (int i = 0; i < moves[1]; i++) {
        // if head/tail are not in the exact same square...
        if (!(headPos[0] == tailPos[0] && headPos[1] == tailPos[1])) {

            switch (moves[0]) {

                  case 'U': 
                    if(tailPos[1] < headPos[1]) {
                        if(tailPos[0] > headPos[0]) {
                            tailPos[0]--;
                        } else if (tailPos[0] < headPos[0]) {
                            tailPos[0]++;
                        }
                        tailPos[1]++;
                    }
                    headPos[1]++;
                    break;

                  case 'D': 
                     if(tailPos[1] > headPos[1]) {
                        if(tailPos[0] > headPos[0]) {
                            tailPos[0]--;
                        } else if (tailPos[0] < headPos[0]) {
                            tailPos[0]++;
                        }
                        tailPos[1]--;
                    }
                    headPos[1]--;
                    break;

                  case 'L': 
                     if(tailPos[0] > headPos[0]) {
                        if(tailPos[1] > headPos[1]) {
                            tailPos[1]--;
                        } else if (tailPos[1] < headPos[1]) {
                            tailPos[1]++;
                        }
                        tailPos[0]--;
                    }
                    headPos[0]--;
                    break;

                  case 'R': 
                     if(tailPos[0] < headPos[0]) {
                        if(tailPos[1] > headPos[1]) {
                            tailPos[1]--;
                        } else if (tailPos[1] < headPos[1]) {
                            tailPos[1]++;
                        }
                        tailPos[0]++;
                    }
                    headPos[0]++;
                    break;

                  default:
                    print("ERROR reading movement direction!");
            }
        // if head/tail are in the same square, only head moves
        } else {
            switch (moves[0]) {
                  case 'U': 
                    headPos[1]++;
                    break;
                  case 'D': 
                    headPos[1]--;
                    break;
                  case 'L': 
                    headPos[0]--;
                    break;
                  case 'R': 
                    headPos[0]++;
                    break;
                  default:
                    print("ERROR reading movement direction!");
            }
        }
        path['H'].add([headPos[0],headPos[1]]);
        path['T'].add([tailPos[0],tailPos[1]]);
    }
    return path;
}

void partOne() {

    List<List> movements = readInput('input-day-9');

    Map moveTracker = {};
    moveTracker['H'] = [[0,0]];
    moveTracker['T'] = [[0,0]];

    Set uniqueSquaresHead = {};
    Set uniqueSquaresTail = {};
    for (var move in movements) {
        moveTracker = executeMoves(move, moveTracker['H'].last, moveTracker['T'].last);
        for (var h in moveTracker['H']) {
            String headString = "${h[0]},${h[1]}";
            uniqueSquaresHead.add(headString);
        }            
        for (var t in moveTracker['T']) {
            String tailString = "${t[0]},${t[1]}";
            uniqueSquaresTail.add(tailString);
        }            
    }

    print(uniqueSquaresTail.length);

}
