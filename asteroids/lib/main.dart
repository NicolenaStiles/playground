// flame-specific stuff
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// global state management
import 'package:get_it/get_it.dart';
import 'src/api/site_state.dart';

import 'src/widgets/game_app.dart';
//import 'src/mobile_asteroids.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void main() {

  getIt.registerSingleton<SiteState>(SiteState());
  getIt.registerSingleton<Leaderboard>(Leaderboard());

  final isMobile = kIsWeb && 
                  (defaultTargetPlatform == TargetPlatform.iOS || 
                   defaultTargetPlatform == TargetPlatform.android);

  getIt<SiteState>().isMobile = isMobile;

  // Adding some test data
  LeaderboardEntry oji = LeaderboardEntry(score: 65536, initals: 'OJI');
  LeaderboardEntry azu = LeaderboardEntry(score: 32768, initals: 'AZU');

  getIt<Leaderboard>().handleScore(oji);
  getIt<Leaderboard>().handleScore(azu);

  runApp(const GameApp());
}
