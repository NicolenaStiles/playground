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

        List<List> movements = readInput('input-day-9-test');

    });
}
