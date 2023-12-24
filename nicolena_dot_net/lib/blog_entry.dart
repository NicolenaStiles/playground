import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class BlogEntry extends StatefulWidget {

  const BlogEntry({ 
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
  State<StatefulWidget> createState() => _BlogEntryState();

}

class _BlogEntryState extends State<BlogEntry>  {

  List<Widget> _generateTags() {
    return widget.tags.map((i) => 
      new DottedBorder(
        color: Color(0xFF00E5FF),
        strokeWidth: 2,
        child: Text(
          i.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontFamily: 'ProFont IIx Nerd Font Mono',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        )
      )).toList();
  }
  
  @override 
  Widget build(BuildContext context) {
    return ( 
        Container( 
          padding: const EdgeInsets.all(4),
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF00E5FF)),
            )
          ),
          child: Center( 
            child: Column( 
              mainAxisSize: MainAxisSize.min,
              children: [
                Row( 
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Expanded( 
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'ProFont IIx Nerd Font Mono',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Text(
                      widget.date,
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
                Row( 
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Expanded(
                      child: Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'ProFont IIx Nerd Font Mono',
                          fontWeight: FontWeight.w400,
                          height: 0,
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
    );
  }
}
