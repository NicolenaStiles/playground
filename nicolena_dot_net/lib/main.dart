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
          builder: (BuildContext context, GoRouterState state) =>
            BlogPostScreen(blogPost: post)
        )
      );
    }

    _routes = GoRouter ( 
      routes: <RouteBase> [ 
        GoRoute( 
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomepageScreen();
          },
          routes: <RouteBase> [
            GoRoute( 
              name: 'about',
              path: 'about',
              builder: (BuildContext context, GoRouterState state) {
                return const AboutScreen();
              },
            ),
            GoRoute( 
              name: 'blog',
              path: 'blog',
              builder: (BuildContext context, GoRouterState state) {
                return BlogScreen(posts: data.posts); 
              },
              routes: blogRoutes,
            ),
            GoRoute( 
              name: 'contact',
              path: 'contact',
              builder: (BuildContext context, GoRouterState state) {
                return const ContactScreen();
              },
            ),
          ],
        ),
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

