import 'package:flutter/material.dart';

import 'blog_entry_list_item.dart';

import 'blog_post.dart';

class BlogEntryListView extends StatefulWidget {

  const BlogEntryListView({ 
    super.key,
    this.posts = const [],
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
              title: widget.posts[index].title!,
              date: widget.posts[index].date!,
              subtitle: widget.posts[index].subtitle!,
              tags: widget.posts[index].tags!,
              route: widget.posts[index].uRL!
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
