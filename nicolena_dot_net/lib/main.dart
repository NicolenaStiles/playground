// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'screens/blog_screen.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nicolena Dot Net Demo',
      theme: websiteTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> titles = <String>[ 'This is a one title for a blog entry.',
                                        'This is a two title for a blog entry.',
                                        'This is a three title for a blog entry.'];

  final List<String> dates = <String>['05/22/1995', '05/22/1995', '05/22/1995'];

  final List<String> subtitles = <String>[ 'This is a one subtitle for a blog entry.',
                                           'This is a two subtitle for a blog entry.',
                                           'This is a three subtitle for a blog entry.'];

  final List<String> tags = <String>['tag 1', 'tag 2', 'tag 3'];

  @override
  Widget build(BuildContext context) {

    return BlogScreen();
    /*
    // testing for blog entry screen
    return BlogEntryScreen(
      title: titles[0],
      date: dates[0],
      subtitle: subtitles[0],
      tags: ['tag 1', 'tag 2', 'tag 3', 'tag 4'],
    );
    */

    /*
    return Scaffold( 
      body: Center( 
        child: Container( 
          constraints: BoxConstraints(minWidth: 375, maxWidth: 1024),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: ShapeDecoration(
            color: Colors.black.withOpacity(1),
            shape: RoundedRectangleBorder( 
              side: BorderSide(width: 2, color: Color(0xFF00B8D4)),
            )
          ),
          child: Center( 
            child: Column( 
              children: [
                // Page Title
                Align( 
                  alignment: Alignment.centerLeft,
                    child: Text(
                      'BLOG',
                        style: Theme.of(context).textTheme.titleLarge,
                    ),
                ),
                // Page Description
                Align( 
                  alignment: Alignment.centerLeft,
                    child: Text(
                      'This is a collection of all my blog entires.',
                        style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ),
                // List of blog entries
                Center( 
                  child: ListView.separated( 
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: titles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BlogEntry(
                        title: titles[index],
                        date: dates[index],
                        subtitle: subtitles[index],
                        tags: ['tag 1', 'tag 2', 'tag 3', 'tag 4'],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      // TODO: fix this, it's such a hack omg
                      color: Colors.white.withOpacity(0),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
    */
  }
}
