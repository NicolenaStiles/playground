import 'dart:io';
import 'package:aoc_2022/aoc_day_10_2022.dart';
import 'package:test/test.dart';

void main() {

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
