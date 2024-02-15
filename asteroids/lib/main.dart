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

  final isMobile = kIsWeb && 
                  (defaultTargetPlatform == TargetPlatform.iOS || 
                   defaultTargetPlatform == TargetPlatform.android);

  getIt<SiteState>().isMobile = true;

  runApp(const GameApp());
}
