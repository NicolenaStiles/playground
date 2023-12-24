import 'package:flutter/material.dart';
import 'package:flutter_tutorials/ui/pages/blog/blog_tag.dart';
import 'package:go_router/go_router.dart';

import 'package/../../common/BacklitText.dart';
import 'package/../../common/BacklitDivider.dart';

import 'package/../../common/center_structure_frame.dart';

import '../pages/blog/blog_entry.dart';
import '../pages/blog/blog_entry_2.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('About Page'),
      ),
      body: Center(
        child: Container(
        constraints: BoxConstraints(minWidth: 375, maxWidth: 1024),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            color: Colors.black.withOpacity(1),
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF00B8D4)),
            ),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Expanded(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: Color(0xFF00E5FF)),
                            ),
                        ),
                        child: Center ( 
                          child: BlogTag(tagText: "test tag"),
                        ),
                    ),
                ),
            ],
        ),
        )        
      ),
    );
  }
}

