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

    test('day-10-part-1', () {

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

    test('day-10-part-2', () {

        // set up CRT
        int widthCRT = 40;
        int heightCRT = 6;
        List<List<String>> crt = [];
        for(int c = 0; c < heightCRT; c++) {
            crt.add(List<String>.generate(widthCRT, (index) => '.'));
        } 

        // set up sprite
        List<String> sprite = List<String>.generate(widthCRT, (index) => '.');

        // simulation setup
        List<String> testCommands = File('input-day-10').readAsLinesSync();

        int cycle = 1;
        int reg = 1;
        int timer = getTimer(testCommands.first);
        int add = getRegAdd(testCommands.first);

        while(testCommands.isNotEmpty) {

            // Execute step

            sprite = sprite.map((e) => '.').toList();
            if (reg == 0) {
                sprite[reg] = '#';
                sprite[reg + 1] = '#';
            } else if (reg < 0) {
                sprite[reg + 1] = '#';
            } else if (reg == widthCRT - 1) {
                sprite[reg] = '#';
                sprite[reg - 1] = '#';
            } else if (reg > widthCRT - 1) {
                sprite[reg - 1] = '#';
            } else {
                sprite[reg - 1] = '#';
                sprite[reg] = '#';
                sprite[reg + 1] = '#';
            }

            crt[((cycle - 1) ~/ widthCRT)][((cycle - 1) % widthCRT)] = sprite[((cycle - 1) % widthCRT)];

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
        drawCRT(crt);

    });
}
