import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:test/test.dart';

void main() {
    test('day-9-part-1', () {

        // reading in data as usual
        List<List> movements = readInput('input-day-9-test');

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

        expect(pathsTail.length, 13);

   });

    test('day-9-part-2', () {
        
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
