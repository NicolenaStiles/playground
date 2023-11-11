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

