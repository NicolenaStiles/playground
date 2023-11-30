
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package/../../common/BacklitText.dart';
import 'package/../../common/BacklitDivider.dart';

class BlogPage extends StatelessWidget {
const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('Blog Page'),
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
                            isSelectable : false,
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

