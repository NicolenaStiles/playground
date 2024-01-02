import 'package:flutter/material.dart';

import '../../common/core_border.dart';
import '../../common/nav_header.dart';
import '../../common/body_border.dart';

import 'blog_entry.dart';


class BlogScreen extends StatefulWidget {

  const BlogScreen({
    super.key,
  });


  @override 
  State<StatefulWidget> createState() => _BlogScreenState();

}

class _BlogScreenState extends State<BlogScreen> {

  final List<String> titles = <String>[ 'This is a one title for a blog entry.',
                                        'This is a two title for a blog entry.',
                                        'This is a three title for a blog entry.'];

  final List<String> dates = <String>['05/22/1995', '05/22/1995', '05/22/1995'];

  final List<String> subtitles = <String>[ 'This is a one subtitle for a blog entry.',
                                           'This is a two subtitle for a blog entry.',
                                           'This is a three subtitle for a blog entry.'];

  @override
  Widget build(BuildContext context) {
    return CoreBorder(
        content: Column ( 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Header
            NavHeader(),
      
            // spacing/padding
            const SizedBox(
              height: 18,
            ),

            // Body
            Container( 
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 6,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF00E5FF),
                  ),
                ),
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

          ],
        ),
    );
  }
}
