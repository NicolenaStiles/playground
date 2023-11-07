import 'package:aoc_2022/aoc_day_1_2022.dart' as day_1;
import 'package:aoc_2022/aoc_day_2_2022.dart' as day_2;
import 'package:aoc_2022/aoc_day_3_2022.dart' as day_3;
import 'package:aoc_2022/aoc_day_4_2022.dart' as day_4;
import 'package:aoc_2022/aoc_day_5_2022.dart' as day_5;
import 'package:aoc_2022/aoc_day_6_2022.dart' as day_6;

void main() {

  int daySelection = 6;
  
  switch (daySelection) {
      case 1: 
        print("Hello and welcome to Day One of AOC 2022!");
        day_1.firstFunction();
        break;
      case 2:
        print("Hello and welcome to Day Two of AOC 2022!");
        day_2.partOne();
        day_2.partTwo();
        break;
     case 3:
        print("Hello and welcome to Day Three of AOC 2022!");
        day_3.partOne();
        day_3.partTwo();
     case 4:  
        print("Hello and welcome to Day Four of AOC 2022!");
        day_4.partOne();
        day_4.partTwo();
        break;
     case 5:
        print("Hello and welcome to Day Five of AOC 2022!");
        day_5.partOneTwo();
     case 6:
        print("Hello and welcome to Day Six of AOC 2022!");
        day_6.partOneTwo();
      default:
        print("Oops! You need to select a day in AOC 2022 to test.");
    }
}
