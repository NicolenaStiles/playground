import 'dart:io';

void partOne() {

    // we're trying to find the sum of the mutual priority items
    int prioritySum = 0;

    // generate priority map
    int minPriority = 1;
    int maxPriority = 52;
    int numLetters = 26;
    int lowercaseOffset = 96;
    int uppercaseOffset = 38;
    Map<String,int> priority = {};
    for (int i = minPriority; i <= maxPriority; i++) {
        if (i <= numLetters) {
            priority[String.fromCharCode(i + lowercaseOffset)] = i;
        } else {
            priority[String.fromCharCode(i + uppercaseOffset)] = i;
        }
    }

    // load "items" from file
    var rucksack = File('input-day-3');
    List<String> items = rucksack.readAsLinesSync();

    for (var item in items) {
        // split item entry into compartments
        int middle = item.length ~/ 2;
        Set c1 = item.substring(0,middle).runes.toSet();
        Set c2 = item.substring(middle,item.length).runes.toSet();

        // check if they have a unique shared entry
        Set shared = c1.intersection(c2);
        if (shared.isNotEmpty == true) {
            int sharedItem = shared.elementAt(0);
            String sharedItemString = String.fromCharCode(sharedItem);
            int pval = priority[sharedItemString]!;
            prioritySum += pval;
        }     
    }
    print(prioritySum);
}

void partTwo() {
    // we're trying to find the sum of the mutual priority items
    int prioritySum = 0;

    // generate priority map
    int minPriority = 1;
    int maxPriority = 52;
    int numLetters = 26;
    int lowercaseOffset = 96;
    int uppercaseOffset = 38;
    Map<String,int> priority = {};
    for (int i = minPriority; i <= maxPriority; i++) {
        if (i <= numLetters) {
            priority[String.fromCharCode(i + lowercaseOffset)] = i;
        } else {
            priority[String.fromCharCode(i + uppercaseOffset)] = i;
        }
    }

    // load "items" from file
    var rucksack = File('input-day-3');
    List<String> items = rucksack.readAsLinesSync();

    // find intersections of sets in team size splits
    int teamSize = 3;
    List<String> teamBadges = [];
    Set currSet = {};
    for (int i = 0; i < items.length; i++) {
        if (i % teamSize == 0) {
            currSet = items[i].runes.toSet();
        } else if (i % teamSize == teamSize - 1){
            Set entry = currSet.intersection(items[i].runes.toSet());
            teamBadges.add(String.fromCharCode(entry.elementAt(0)));
        } else {
            currSet = currSet.intersection(items[i].runes.toSet());
        }
    } 

    // map to priority values
    for (var badge in teamBadges) {
        prioritySum += priority[badge]!;
    }
    print(prioritySum);
}
