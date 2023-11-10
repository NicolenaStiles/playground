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
