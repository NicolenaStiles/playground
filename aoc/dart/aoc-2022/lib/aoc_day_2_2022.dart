import 'dart:io';

void partOne(){

    var rounds = File('rockpaperscissors');
    List<String> lines = rounds.readAsLinesSync();

    int totalScore = 0;
    for (var l in lines) {
        switch (l[2]) {
            // rock
            case 'X':
                totalScore += 1;
                switch (l[0]) {
                    case 'A':
                        totalScore += 3;
                        break;
                    case 'B':
                        totalScore += 0;
                        break;
                    case 'C':
                        totalScore += 6;
                        break;
                    default:
                        print("Opponent character entry not recognized!");

                }
                break;
            // paper
            case 'Y':
                totalScore += 2;
                switch (l[0]) {
                    case 'A':
                        totalScore += 6;
                        break;
                    case 'B':
                        totalScore += 3;
                        break;
                    case 'C':
                        totalScore += 0;
                        break;
                    default:
                        print("Opponent character entry not recognized!");

                }
                break;
            // scissors
            case 'Z':
                totalScore += 3;
                switch (l[0]) {
                    case 'A':
                        totalScore += 0;
                        break;
                    case 'B':
                        totalScore += 6;
                        break;
                    case 'C':
                        totalScore += 3;
                        break;
                    default:
                        print("Opponent character entry not recognized!");

                }
                break;
            default:
                print("Player character entry not recognized!");
        }
    }
    print("Final score pt 1: $totalScore");
}

void partTwo() {

    var rounds = File('rockpaperscissors');
    List<String> lines = rounds.readAsLinesSync();

    int totalScore = 0;
    for (var ch in lines) {
        switch (ch[2]) {
            case 'X':
                totalScore += 0;
                switch (ch[0]) {
                case 'A':
                    totalScore += 3;
                    break; 
                case 'B':
                    totalScore += 1;
                    break;
                case 'C':
                    totalScore += 2;
                    break; 
                  default:
                    print("Player character entry not recognized!");
                }
                break; 
            case 'Y':
                totalScore += 3;
                switch (ch[0]) {
                    case 'A':
                        totalScore += 1;
                        break; 
                    case 'B':
                        totalScore += 2;
                        break;
                    case 'C':
                        totalScore += 3;
                        break; 
                      default:
                        print("Player character entry not recognized!");
                    }
                    break;
            case 'Z':
                totalScore += 6;
                switch (ch[0]) {
                    case 'A':
                        totalScore += 2;
                        break; 
                    case 'B':
                        totalScore += 3;
                        break;
                    case 'C':
                        totalScore += 1;
                        break; 
                      default:
                        print("Player character entry not recognized!");
                    } 
                break; 
              default:
                print("Outcome character entry not recognized!");
            }          
    }
    print("Final score pt 2: $totalScore");
}
