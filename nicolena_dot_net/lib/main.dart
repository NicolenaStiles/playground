// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme.dart';

import 'ui/screens/home/homepage_screen.dart';
import 'ui/screens/about/about_screen.dart';
import 'ui/screens/blog/blog_screen.dart';
import 'ui/screens/contact/contact_screen.dart';

void main() => runApp(MyApp());

final GoRouter _router = GoRouter ( 
  routes: <RouteBase> [ 
    GoRoute( 
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomepageScreen();
      },
      routes: <RouteBase> [
        GoRoute( 
          path: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutScreen();
          },
        ),
        GoRoute( 
          path: 'blog',
          builder: (BuildContext context, GoRouterState state) {
            return const BlogScreen();
          },
        ),
        GoRoute( 
          path: 'contact',
          builder: (BuildContext context, GoRouterState state) {
            return const ContactScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {

  const MyApp({ 
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Nicolena Dot Net Demo',
      theme: websiteTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );

  }
}

