import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:test/test.dart';

void main() {
    test('day-9-part-1', () {
        // Made sure load-in process is correct
        List<List> movements = readInput('input-day-9-test');
        expect(movements[0].length, 2);
        expect(movements[0][0], 'R');
        expect(movements[0][1], 4);
        
        // test out movement logic
        List<int> head = [0,0];
        List<int> tail = [0,0];

        // First movement is R 4
        // Expect Head = 4,0
        // Expect Tail = 3,0
        Map movementTracker = executeMoves(movements[0], head, tail);
        expect(movementTracker['H'].last, [4,0]);
        expect(movementTracker['T'].last, [3,0]);

        // Second movement is U 4
        // Expect Head = 4,4
        // Expect Tail = 4,3
        Map movementTracker2 = executeMoves(movements[1], movementTracker['H'].last, movementTracker['T'].last);
        expect(movementTracker2['H'].last, [4,4]);
        expect(movementTracker2['T'].last, [4,3]);

        // Skip some steps and test out the uniqueness process w/sets
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
        // Correct solution as per website
        expect(uniqueSquaresTail.length, 13);

    });

    test('day-9-part-2', () {
        
        // reading in data as usual
        List<List> movements = readInput('input-day-9-test');

        // for real this time
        List<int> currHead = [0,0];
        List<int> currTail = [0,0];
        Set pathsHead = {};
        Set pathsTail= {};
        for(var move in movements) {
            print("Move: $move");
            for(int i = 0; i < move[1]; i++) {
                currHead = moveHead(move[0], currHead);
                currTail = moveFollower(currHead, currTail);
                String headPath = "${currHead[0]},${currHead[1]}";
                pathsHead.add(headPath);
                String tailPath = "${currTail[0]},${currTail[1]}";
                pathsTail.add(tailPath);
            }
        }
        expect(pathsTail.length, 13);

        /*
        // Starting info for knots
        int numKnots = 10;
        List<List<int>> pos = List<List<int>>.generate(numKnots, (i) => [0,0]);
        expect(pos.length, 10);

        List<List<int>> endPos = [[]];

        // trying just one test movement first...
        for (int i = 0; i < movements[0][1]; i++) {
            print("input positions: $pos");
            endPos = singleMove(movements[0][0], pos);
            pos = endPos;
        }
        expect(endPos[0],[4,0]);
        expect(endPos[1],[3,0]);
        expect(endPos[2],[2,0]);
        expect(endPos[3],[1,0]);
        */

    });
}
