import 'dart:io';
import 'package:aoc_2022/aoc_day_9_2022.dart';
import 'package:aoc_2022/aoc_day_10_2022.dart';
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
        
    });

    test('day-10-mini-test', () {

        List<String> testCommands = ['noop', 'addx 3','addx -5'];

        int cycle = 1;
        int reg = 1;
        int timer = getTimer(testCommands.first);
        int add = getRegAdd(testCommands.first);

        while(testCommands.isNotEmpty) {

            // Execute step
            print("Cycle: $cycle Reg: $reg Executing: ${testCommands.first}");

            // End of cycle
            cycle++;
            timer--;
            if (timer == 0) {
                if (testCommands.length > 1) {
                    reg = reg + add;
                    testCommands.removeAt(0);
                    timer = getTimer(testCommands.first); 
                    add = getRegAdd(testCommands.first);
                } else {
                    reg = reg + add;
                    testCommands.removeAt(0);
                }
            }
        }
        print("Simulation ended!");
        print("Cycle: $cycle Reg: $reg");
    });

    test('day-10-mega-test', () {

        List<String> testCommands = File('input-day-10-test').readAsLinesSync();

        int cycle = 1;
        int reg = 1;
        int timer = getTimer(testCommands.first);
        int add = getRegAdd(testCommands.first);

        while(testCommands.isNotEmpty) {

            // Execute step
            print("Cycle: $cycle Reg: $reg Executing: ${testCommands.first}");
            switch (cycle) {
                case 20:
                    expect(reg, 21);
                    break;
                case 60:
                    expect(reg, 19);
                break;
                case 100:
                    expect(reg, 18);
                break;
                case 140:
                    expect(reg, 21);
                break;
                case 180:
                    expect(reg, 16);
                break;
                case 220:
                    expect(reg, 18);
                break;
              default:
            }

            // End of cycle
            cycle++;
            timer--;
            if (timer == 0) {
                if (testCommands.length > 1) {
                    reg = reg + add;
                    testCommands.removeAt(0);
                    timer = getTimer(testCommands.first); 
                    add = getRegAdd(testCommands.first);
                } else {
                    reg = reg + add;
                    testCommands.removeAt(0);
                }
            }
        }
        print("Simulation ended!");
        print("Cycle: $cycle Reg: $reg");
    });
}
