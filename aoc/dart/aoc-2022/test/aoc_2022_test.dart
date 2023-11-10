import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:test/test.dart';

void main() {
    test('mini-test', () {
        print("Basic direction testing:");
        print("UP");

        String move = 'U';


        List<List<int>> head = [[0,0],[1,1],[1,-2],[1,-1]];
        List<List<int>> tail = [[0,0],[1,0],[1,-3],[1,0]];
        List<List<int>> endTail = [[0,0],[1,1],[1,-2],[1,0]];
        for(int i = 0; i < head.length; i++) {
            List<int> currHead = head[i];
            List<int> currTail = tail[i];
            print("before");
            print(currHead);
            print(head[i]);
            currHead = moveHead(move, currHead);
            print("after");
            print(currHead);
            print(head[i]);
            expect(currHead,[head[i][0],head[i][1]+1]);
            currTail = moveFollower(currHead, currTail);
            expect(currTail,endTail[i]);
        }

        move = 'D';
        print("DOWN");
    });

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
