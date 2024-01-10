import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';

import 'package:nicolena_dot_net/api/blog_post.dart';

class BlogEntryListItem extends StatefulWidget {

  const BlogEntryListItem({ 
    super.key,
    required this.blogPost,
  });

  final BlogPost blogPost;

  @override
  State<StatefulWidget> createState() => _BlogEntryListItemState();

}

class _BlogEntryListItemState extends State<BlogEntryListItem> {

  // define border style here
  BoxDecoration _currBorderDecor = BoxDecoration(
                                    border: Border.all(
                                        color: Colors.cyan,
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  );


  void _swapBorder(bool hover) {
    setState(() {

      if (hover) {
        _currBorderDecor = BoxDecoration(
                                      color: Colors.black ,
                                      border: Border.all(
                                          color: Colors.cyan,
                                          width: 2,
                                          strokeAlign: BorderSide.strokeAlignInside,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.cyan,
                                          blurRadius: 16,
                                          offset: Offset(0,0),
                                        ),
                                      ],
                                    );
      } else {
        _currBorderDecor =  BoxDecoration(
                                  border: Border.all(
                                      color: Colors.cyan,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                );

      }
    });
  }

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
  Widget build(BuildContext context) {
    return ( 
      MouseRegion(
        onEnter: (_) {
          _swapBorder(true);
        },

        onExit: (_) {
          _swapBorder(false);
        },

        child: GestureDetector( 
          onTap: () {
            context.go('/blog/${widget.blogPost.uRL!}');
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: _currBorderDecor,
            child: Center( 
              child: Column( 
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row( 
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      Expanded( 
                        child: Container( 
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            widget.blogPost.title!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          widget.blogPost.date!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Row( 
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      Expanded(
                        child: Container( 
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            widget.blogPost.subtitle!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _generateTags(),
                  ),
                ],
              ),
            ),
          )

        )
      )
    );
  }
}
