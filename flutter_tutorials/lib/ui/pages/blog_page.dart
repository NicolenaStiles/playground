
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('Blog Page'),
      ),
      body: Center (

        child: ElevatedButton(
          onPressed: () {
            context.go('/');
          }, child: const Text('Back to homepage'),
        )

      ),
    );
  }
}

