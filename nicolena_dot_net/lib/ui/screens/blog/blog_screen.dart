import 'package:flutter/material.dart';

import '../../common/core_border.dart';
import '../../common/nav_header.dart';
import '../../common/body_border.dart';
import '../../common/tab_header.dart';

import 'blog_entry_list_view.dart';
import 'package:nicolena_dot_net/api/blog_post.dart';

class BlogScreen extends StatefulWidget {

  const BlogScreen({
    super.key,
    required this.posts,
  });

  final List<BlogPost> posts;

  @override 
  State<StatefulWidget> createState() => _BlogScreenState();

}

class _BlogScreenState extends State<BlogScreen> {

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
            BodyBorder(
              content: Center( 
                child: Column( 
                  children: [

                    // Page Description
                    TabHeader(tabHeaderText: '//BLOG'),
                      
                    // spacing/padding
                    const SizedBox(
                      height: 18,
                    ),

                    Align( 
                      alignment: Alignment.centerLeft,
                        child: Text(
                          'This is a collection of all my blog entires.',
                            style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ),

                    // List of blog entries
                    BlogEntryListView(posts: widget.posts),
                  ],
                ),
              ),
            ),

          ],
        ),
    );
  }
}
