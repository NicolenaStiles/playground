// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'dart:convert';

import 'theme.dart';

import 'ui/screens/home/homepage_screen.dart';
import 'ui/screens/about/about_screen.dart';
import 'ui/screens/blog/blog_screen.dart';
import 'ui/screens/blog/blog_post_screen.dart';
import 'ui/screens/contact/contact_screen.dart';

import 'package:parallax_rain/parallax_rain.dart';

import 'package:nicolena_dot_net/api/blog_post.dart';

Future<String> _loadAssetData() async {
  return await rootBundle.loadString('assets/blog/BlogManifest.json');
}

Future<BlogData> fetchData() async {
  String jsonString = await _loadAssetData();
  final jsonResponse = json.decode(jsonString);
  BlogData blogData = BlogData.fromJson(jsonResponse);
  return blogData;
}

void main() { 
  // to remove the '#' in the URL.
  // DO NOT CHANGE IT TO CONSTANT THE LSP IS LYING
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  late GoRouter _routes;
  List<GoRoute> blogRoutes = [];

  Future<BlogData> blogData = fetchData();
  blogData.then((data) {

    for (var post in data.posts) {
      blogRoutes.add(
        GoRoute(
          name: post.uRL!,
          path: post.uRL!,
          pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage(child: BlogPostScreen(blogPost: post))
        )
      );
    }

    _routes = GoRouter ( 
      initialLocation: '/',
      routes: [ 
        ShellRoute( 
          builder: ( 
            BuildContext context,
            GoRouterState state,
            Widget child,
          ) {
            return Scaffold( 
              body: ParallaxRain( 
                dropColors: const [
                  Colors.cyan,
                ],
                trail: true,
                rainIsInBackground: true,
                dropFallSpeed: 1,
                numberOfDrops: 250,
                trailStartFraction: 0.35,
                child: child,
              ),
            );
          },

          routes: <RouteBase> [ 
            GoRoute( 
              path: '/',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: HomepageScreen());
              },

              routes: <RouteBase> [
                GoRoute( 
                  name: 'about',
                  path: 'about',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(child: AboutScreen());
                  },
                ),

                GoRoute( 
                  name: 'blog',
                  path: 'blog',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(child: BlogScreen(posts: data.posts));
                  },
                  routes: blogRoutes,
                ),

                GoRoute( 
                  name: 'contact',
                  path: 'contact',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(child: ContactScreen());
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );

    runApp(
      MaterialApp.router(
        title: 'Nicolena Dot Net Demo',
        theme: websiteTheme,
        debugShowCheckedModeBanner: false,
          routerConfig: _routes,
      ));

  });

}

