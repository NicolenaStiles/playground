import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../theme.dart';

class BlogPostScreen extends StatefulWidget {

  const BlogPostScreen({ 
    super.key,
    this.title = "",
    this.date = "",
    this.subtitle = "",
    this.tags = const [],
  });

  final String title;
  final String date;
  final String subtitle;
  final List<String> tags;

  @override
  State<StatefulWidget> createState() => _BlogPostScreenState();

}

const String _markdownData = """
# Minimal Markdown Test
---
This is a simple Markdown test. Provide a text string with Markdown tags
to the Markdown widget and it will display the formatted output in a
scrollable widget.

## Section 1
Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
eget est condimentum, vitae porttitor diam ornare.

### Subsection A
Sed et massa finibus, blandit massa vel, vulputate velit. Vestibulum vitae
venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
accumsan ante.__** Sed a fermentum elit. Curabitur sodales metus id mi
ornare, in ullamcorper magna congue.
""";

class _BlogPostScreenState extends State<BlogPostScreen> {
  

  List<Widget> _generateTags() {

    return widget.tags.map((i) => 
      new Container(
        padding: const EdgeInsets.all(4),
        child: DottedBorder(
          color: Color(0xFF00E5FF),
          strokeWidth: 2,
          padding: const EdgeInsets.all(4),
          child: Text(
            i.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          )
        )
      )).toList();

  }

  @override
  Widget build(BuildContext context){
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
                      child: Container( 
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                ),
                // Post Date
                Align( 
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      widget.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                // Subtitle
                Align( 
                  alignment: Alignment.centerLeft,
                  child: Container( 
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                // Tags list
                Row( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _generateTags(),
                ),
                // Actual blog entry
                Expanded(
                  child: Markdown(
                    data: _markdownData,
                    styleSheet: websiteMarkdown, 
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
