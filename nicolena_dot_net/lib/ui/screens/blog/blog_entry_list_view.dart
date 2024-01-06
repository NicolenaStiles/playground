import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'blog_entry_list_item.dart';

class BlogEntryListView extends StatefulWidget {

  const BlogEntryListView({ 
    super.key,
  });

  @override 
  State<StatefulWidget> createState() => _BlogEntryListViewState();

}

class _BlogEntryListViewState extends State<BlogEntryListView> {

  // TODO: replace these with actual metadata
  final List<String> titles = <String>[ 'This is a one title for a blog entry.',
                                        'This is a two title for a blog entry.',
                                        'This is a three title for a blog entry.'];

  final List<String> dates = <String>['05/22/1995', '05/22/1995', '05/22/1995'];

  final List<String> subtitles = <String>[ 'This is a one subtitle for a blog entry.',
                                           'This is a two subtitle for a blog entry.',
                                           'This is a three subtitle for a blog entry.'];

  @override 
  Widget build(BuildContext context) {
    return ( 
      Center( 
        child: ListView.separated( 
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: titles.length,
          itemBuilder: (BuildContext context, int index) {
            return BlogEntryListItem(
              title: titles[index],
              date: dates[index],
              subtitle: subtitles[index],
              tags: ['tag 1', 'tag 2', 'tag 3', 'tag 4'],
              route: '/blog/entry_1'
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
