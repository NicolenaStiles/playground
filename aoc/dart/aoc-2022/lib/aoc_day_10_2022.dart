import 'dart:io';

int getTimer(String command) {

    int timer = 0;
    List<String> cmd = command.split(' ');

    switch (cmd[0]) {
          case 'noop':
            timer = 1;
            break;
          case 'addx':
            timer = 2;
            break;
          default:
            print("Bad input value!");
    }

    return timer;

}

int getRegAdd(String command) {

    int regAdd = 0;
    List<String> cmd = command.split(' ');

    switch (cmd[0]) {
          case 'noop':
            regAdd = 0;
            break;
          case 'addx':
            regAdd= int.parse(cmd[1]);
            break;
          default:
            print("Bad input value!");
    }

    return regAdd;

}

void drawCRT(List<List<String>> pixels) {

    for (var r in pixels) {
        print(r.join());
    }

}

void runSimulation(List<String> commands, List<int> cycleSignalStrengths) {

        List<String> testCommands = commands; 

        int cycle = 1;
        int reg = 1;
        int timer = getTimer(testCommands.first);
        int add = getRegAdd(testCommands.first);

        int signalStrengthSum = 0;

        while(testCommands.isNotEmpty) {

            // Execute step
            if(cycleSignalStrengths.contains(cycle)) {
                print("$cycle has signal strength ${cycle * reg}");
                signalStrengthSum = signalStrengthSum + (cycle * reg);
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
        print("Signal strength sum is $signalStrengthSum");

}

void partOne() {

    List<String> testCommands = File('input-day-10').readAsLinesSync();
    List<int> cycleSignalStrengths = [20,60,100,140,180,220];

    runSimulation(testCommands, cycleSignalStrengths);

}

void partTwo() {

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

        drawCRT(crt);

}

