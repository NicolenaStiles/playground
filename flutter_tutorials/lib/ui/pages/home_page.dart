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
      body: Center(
        child: Column( 
          children: [

            ElevatedButton(
              onPressed: () {
                context.go('/about');
              }, child: const Text('ABOUT'),
            ),

            ElevatedButton(
              onPressed: () {
                context.go('/blog');
              }, child: const Text('BLOG'),
            ),

            ElevatedButton(
              onPressed: () {
                context.go('/contact');
              }, child: const Text('CONTACT'),
            ),

            // experimental button here
            TextButton( 

              // press action
              onPressed: () {
                context.go('/about');
              },

              // disabling "splash effects"
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>( 
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
                splashFactory: NoSplash.splashFactory,
              ),

              // actual button text setup
              child: const Text(
                'TEST BUTTON', 
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.white, 
                  fontFamily: 'ProFontIIx'
                )
              ),
            ),
            
            const Column( 
              children: [ 
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    BacklitText(textEntry: 'ABOUT', isSelectable : true),
                    BacklitDivider(),
                    BacklitText(textEntry: 'BLOG', isSelectable : true),
                    BacklitDivider(),
                    BacklitText(textEntry: 'CONTACT', isSelectable : true),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
