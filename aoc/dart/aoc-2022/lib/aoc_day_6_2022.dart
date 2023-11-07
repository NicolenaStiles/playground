import 'dart:io';

List<String> findPacket(int windowSize, List<String> msg) {
    List<String> window = [];

    for (var i = 0; i < msg.length; i++) {
        if (i < windowSize - 1) {
            window.add(msg[i]);
        } else if (i == windowSize - 1) {
            window.add(msg[i]);
            if (window.toSet().length == windowSize) {
                print("Found early unique window!");
                print("$window @ ${i+1}");
                return window;
            }
        } else {
            window.removeAt(0);
            window.add(msg[i]);
            if (window.toSet().length == windowSize) {
                print("Found unique window!");
                print("$window @ ${i+1}");
                return window;
            }
        }
    }
    return window;
}

void partOneTwo() {
    // load assignments from file
    var inputFile = File('input-day-6');
    List<String> readIn = inputFile.readAsLinesSync();

    // split message into list of characters
    List<String> message = readIn[1].split("");

    // sliding window
    List<String> header = findPacket(4, message);
    print(header);
    
    // sliding window
    List<String> msgHeader = findPacket(14, message);
    print(msgHeader);
}
