import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Tutorials',
      initialRoute: '/',
      routes: {

        '/': (context) => const HomePage(),
        '/about': (context) => const AboutScreen(),
        '/blog': (context) => const BlogScreen(),
        '/contact': (context) => const ContactScreen(),
      },
      theme: ThemeData(

        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
    );
  }
}

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
                Navigator.pushNamed(context, '/about');
              }, child: const Text('About page'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/blog');
              }, child: const Text('Blog'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/contact');
              }, child: const Text('Contact info page'),
            )
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('About Page'),
      ),
      body: Center (

        child: ElevatedButton(
          onPressed: () {
          Navigator.pop(context);
          }, child: const Text('Back to homepage'),
        )

      ),
    );
  }
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('Blog Page'),
      ),
      body: Center (

        child: ElevatedButton(
          onPressed: () {
          Navigator.pop(context);
          }, child: const Text('Back to homepage'),
        )

      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('Contact Page'),
      ),
      body: Center (

        child: ElevatedButton(
          onPressed: () {
          Navigator.pop(context);
          }, child: const Text('Back to homepage'),
        )

      ),
    );
  }
}

