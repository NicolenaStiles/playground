import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/about_page.dart';
import 'ui/pages/blog_page.dart';
import 'ui/pages/contact_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter ( 
  routes: <RouteBase> [ 
    GoRoute( 
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase> [
        GoRoute( 
          path: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutPage();
          },
        ),
        GoRoute( 
          path: 'blog',
          builder: (BuildContext context, GoRouterState state) {
            return const BlogPage();
          },
        ),
        GoRoute( 
          path: 'contact',
          builder: (BuildContext context, GoRouterState state) {
            return const ContactPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Flutter Tutorials',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

