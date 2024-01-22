import 'package:flutter/material.dart';

import '../../common/core_border.dart';
import '../../common/nav_header.dart';
import '../../common/body_border.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../theme.dart';

import 'package:nicolena_dot_net/api/blog_post.dart';

class BlogPostScreen extends StatefulWidget {

  const BlogPostScreen({ 
    super.key,
    required this.blogPost,
  });

  final BlogPost blogPost;

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

    return widget.blogPost.tags!.map((i) => 
      Container(
        padding: const EdgeInsets.all(4),
        child: DottedBorder(
          color: const Color(0xFF00E5FF),
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
    return CoreBorder(
        content: ListView ( 
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.antiAlias,
          children: [

            // Header
            const NavHeader(),

            // spacing/padding
            const SizedBox(
              height: 18,
            ),

              // Body
              BodyBorder(
                //content: SingleChildScrollView( 
                content:  Center( 
                  child: Column( 
                    children: [
                    // Page Title
                    Align( 
                      alignment: Alignment.centerLeft,
                      child: Container( 
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          widget.blogPost.title!,
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
                          widget.blogPost.date!,
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
                            widget.blogPost.subtitle!,
                            style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                    // Tags list
                    Row( 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _generateTags(),
                       ),      
                    Markdown(
                        data: _markdownData,
                        styleSheet: websiteMarkdown, 
                        shrinkWrap: true,
                        ),
                    ],
                    ),
                    ),
                    //),
                    ),
          ],
       ),
    );
  //content    );
  }
}

/*

              // Body
              BodyBorder(
                //content: SingleChildScrollView( 
                content:  Center( 
                  child: Column( 
                    children: [
                    // Page Title
                    Align( 
                      alignment: Alignment.centerLeft,
                      child: Container( 
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          widget.blogPost.title!,
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
                          widget.blogPost.date!,
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
                            widget.blogPost.subtitle!,
                            style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                    // Tags list
                    Row( 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _generateTags(),
                       ),      
                    Markdown(
                        data: _markdownData,
                        styleSheet: websiteMarkdown, 
                        shrinkWrap: true,
                        ),
                    ],
                    ),
                    ),
                    //),
                    ),
*/ 
