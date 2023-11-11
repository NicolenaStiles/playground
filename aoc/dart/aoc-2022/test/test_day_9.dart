import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:test/test.dart';

void main() {

    // Test process of defining bounds
    test('day-9-test-bounds', () {

        List<List> movements = readInput('input-day-9-test');
        List<int> bounds = getBounds(movements);

        // lowest possible bound, should always be zero
        expect(bounds[0], 0);
        // upper bound, will be used to make square
        expect(bounds[1], 5);
        print(bounds);

    });

    // test out drawing positions
    test('day-9-test-drawing', () {

        List<String> names = ['H', 'T'];
        List<List<int>> positions = [[0,0], [0,0]];

        drawKnots(5, positions, names);
    });

    // actual testing of knot movement again
    test('day-9-part-1', () {

        // reading in data as usual
        List<List> movements = readInput('input-day-9-test');

        // for real this time
        // for drawing
        List<String> names = ['H','T'];
        int bound = getBounds(movements)[1];
        print('Bounds: $bound');
        
        // prereqs
        List<int> currHead = [0,0];
        List<int> currTail = [0,0];
        Set pathsHead = {};
        Set pathsTail= {};
        pathsHead.add("0,0");
        pathsTail.add("0,0");

        for(var move in movements) {
            print('Current movement: $move');
            for(int i = 0; i < move[1]; i++) {

                currHead = moveHead(move[0], currHead);
                currTail = moveFollower(currHead, currTail);
                
                drawKnots(bound+1, [currHead,currTail], names);
                print('----------------');

                String headPath = "${currHead[0]},${currHead[1]}";
                pathsHead.add(headPath);
                String tailPath = "${currTail[0]},${currTail[1]}";
                pathsTail.add(tailPath);
            }
        }

        expect(pathsTail.length, 13);

    });

    test('day-9-part-2', () {

        // reading in data as usual
        List<List> movements = readInput('input-day-9-test-2');
        int bound = getBounds(movements)[1];

        // for real this time
        List<String> names = ['H','1','2','3','4','5','6','7','8','T'];
        List<Set> paths = [];
        int numKnots = 10;
        List<List<int>> currPos = [];
        for(int i = 0; i < numKnots; i++) {
            currPos.add([0,0]);
            paths.add({'0,0'});
        } 

        // movement algorithim
        for(var move in movements) {
            print("Current move: $move");
            for(int i = 0; i < move[1]; i++) {
                for (int k = 0; k < numKnots; k++) {

                    if (k == 0) {
                        currPos[0] = moveHead(move[0], currPos[k]);
                    } else {
                        currPos[k] = moveFollower(currPos[k-1], currPos[k]);
                    }

                    String currPath = '${currPos[k][0]},${currPos[k][1]}';
                    paths[k].add(currPath);

                }
            }

            drawKnots(bound+1, currPos, names);
            print('----------------');

        }

       print(paths.last.length);

    });
}
