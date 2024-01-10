import 'package:blog_engine_test/blog_post.dart';
import 'package:flutter/material.dart';

import 'core_border.dart';
import 'blog_entry_list_view.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({ 
    super.key,
    this.posts = const [],
  });

  final List<BlogPost> posts;

  @override
  State<StatefulWidget> createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center( 
        child: CoreBorder(
          content: BlogEntryListView(posts: widget.posts),
        )
      ),
    );
  }
}
