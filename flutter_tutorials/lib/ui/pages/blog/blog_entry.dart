import 'package:flutter/material.dart';
import 'blog_tag.dart';

import '../../common/fonts/regular_text.dart';
import '../../common/fonts/subheading_text.dart';

class BlogEntry extends StatefulWidget {
  const BlogEntry({ 
    super.key,
    this.title = "",
    this.date = "",
    this.subtitle = "",
  });

  final String title;
  final String date;
  final String subtitle;

  @override 
  State<StatefulWidget> createState() => _BlogEntryState();

}

class _BlogEntryState extends State<BlogEntry> {
  @override 
  Widget build(BuildContext context) {
    return (
Center( 
  child: Container(
    constraints: BoxConstraints(minHeight: 38, maxHeight: 200),
    padding: const EdgeInsets.all(2),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
    child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Expanded(
                child: Container(
                    height: 34,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                child: SizedBox(
                                    child: Text(
                                        'This is a test title',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontFamily: 'ProFont IIx Nerd Font Mono',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            const SizedBox(width: 10),
            Container(
                width: 149,
                height: double.infinity,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            'MM/DD/YYYY',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontFamily: 'ProFont IIx Nerd Font Mono',
                                fontWeight: FontWeight.w400,
                                height: 0,
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
)
)
    );
  }
}
