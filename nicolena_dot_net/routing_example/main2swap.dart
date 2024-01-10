import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'list_screen.dart';
import 'blog_post.dart';
import 'entry_screen.dart';

void main() { 
  // to remove the '#' in the URL.
  // DO NOT CHANGE IT TO CONSTANT THE LSP IS LYING
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

final GoRouter _router = GoRouter( 
  routes: <RouteBase> [
    GoRoute( 
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
        const RoutingHelper(),
      routes: <GoRoute>[
        GoRoute(
          name: 'entry',
          path: ':uRL',
          builder: (BuildContext context, GoRouterState state) =>
            EntryScreen(uRL: state.pathParameters['uRL']!),
        )
      ]
    ),
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

class RoutingHelper extends StatefulWidget {
  const RoutingHelper({ 
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RoutingHelperState();

}

Future<String> _loadAssetData() async {
  return await rootBundle.loadString('assets/blog/BlogManifest.json');
}

class _RoutingHelperState extends State<RoutingHelper> {

  Future<BlogData> fetchData() async {
    String jsonString = await _loadAssetData();
    final jsonResponse = json.decode(jsonString);
    BlogData blogData = BlogData.fromJson(jsonResponse);
    return blogData;
  }

  late Future<BlogData> blogData;

  @override
  void initState() {
    super.initState();
    blogData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: FutureBuilder<BlogData>( 
        future: blogData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListScreen(posts: snapshot.data!.posts);
          } else if (snapshot.hasError) {
            print("lol error");
          }
          return const CircularProgressIndicator();
          }),
        );
  }

}
