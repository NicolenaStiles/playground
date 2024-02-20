class LeaderboardEntry {

  int score;
  String initals;

  LeaderboardEntry({ 
    required this.score,
    required this.initals,
  });
}

class Leaderboard {

  List<LeaderboardEntry> highScores = [];
  int minScore = 0;

  // see if new score can be added to leaderboard
  bool verifyScore(int score) {
    if (highScores.isEmpty || highScores.length < 10) {
      return true;
    } else {
      if (score > minScore) {
        return true;
      } else {
        return false;
      }
    }
  }

  // if yes, it updates leaderboard and returns true
  // otherwise returns false
  void handleScore(LeaderboardEntry entry) {

    if (highScores.isEmpty || highScores.length < 10) {
      highScores.add(entry);
      highScores.sort((b,a) => a.score.compareTo(b.score));
      minScore = highScores.last.score;

    } else {
      highScores.removeLast();
      highScores.add(entry);
      highScores.sort((b,a) => a.score.compareTo(b.score));
      minScore = highScores.last.score;
    }
  }

  void printLeaderboard() {
    if (highScores.isEmpty) {
      print('No scores in leaderboard!');
    } else {
      for (int i = 0; i < highScores.length; i++) {
        print('${i+1}: ${highScores[i].score} ${highScores[i].initals}');
      }
    }
  }
}

class SiteState {
  bool isMobile = false;
}
