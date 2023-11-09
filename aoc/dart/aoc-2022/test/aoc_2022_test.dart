import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:test/test.dart';

void main() {
    test('day-9', () {
        // Made sure load-in process is correct
        List<List> movements = readInput('input-day-9-test');
        expect(movements[0].length, 2);
        expect(movements[0][0], 'R');
        expect(movements[0][1], 4);
        
        // test out movement logic
        List<List<int>> head = [[0,0]];
        List<List<int>> tail = [[0,0]];

    });
}
