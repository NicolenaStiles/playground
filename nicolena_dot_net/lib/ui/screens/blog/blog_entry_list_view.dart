import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'blog_entry_list_item.dart';
import 'package:nicolena_dot_net/api/blog_post.dart';

class BlogEntryListView extends StatefulWidget {

  const BlogEntryListView({ 
    super.key,
    required this.posts,
  });

  final List<BlogPost> posts;

  @override 
  State<StatefulWidget> createState() => _BlogEntryListViewState();

}

class _BlogEntryListViewState extends State<BlogEntryListView> {

  @override 
  Widget build(BuildContext context) {
    return ( 
      Center( 
        child: ListView.separated( 
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget.posts.length,
          itemBuilder: (BuildContext context, int index) {
            return BlogEntryListItem(
              blogPost: widget.posts[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            // TODO: fix this, it's such a hack omg
            color: Colors.white.withOpacity(0),
          ),
        )
      )
    );
  }
}
