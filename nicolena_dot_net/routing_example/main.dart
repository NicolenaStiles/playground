import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'list_screen.dart';
import 'blog_post.dart';
import 'entry_screen.dart';

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
            EntryScreen(title: post.title!, uRL: post.uRL!),
        )
      );
    }

    _routes = GoRouter( 
      routes: <RouteBase> [
        GoRoute( 
          name: 'entries',
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
            ListScreen(posts: data.posts),
          routes: blogRoutes,
        ),
      ]
    );

    runApp(
      MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routerConfig: _routes,
      ));

  });

}

