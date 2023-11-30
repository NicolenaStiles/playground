import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package/../../common/BacklitText.dart';
import 'package/../../common/BacklitDivider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('Contact Page'),
      ),
      body: Center(
        child: Column( 
          children: [ 
            ElevatedButton(
              onPressed: () {
                context.go('/');
              }, child: const Text('Back to homepage'),
            ),
            const Row( 
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
                            isSelectable : false,
                            route: '/contact'),
              ],
            ),
          ],
        )
      ),
    );
  }
}

