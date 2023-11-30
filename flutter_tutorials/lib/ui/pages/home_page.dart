import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/BacklitText.dart';
import '../common/BacklitDivider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Column( 
          children: [ 
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 

                BacklitText(textEntry : 'ABOUT', 
                            isSelectable : true, 
                            route  : '/about'),
                BacklitDivider(),

                BacklitText(textEntry : 'BLOG', 
                            isSelectable : true,
                            route : '/blog'),
                BacklitDivider(),

                BacklitText(textEntry : 'CONTACT', 
                            isSelectable : true,
                            route: '/contact'),
              ],
            ),
          ],
        )
      ),
    );
  }
}
