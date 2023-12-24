import 'package:flutter/material.dart';

class BlogTag extends StatefulWidget {
  const BlogTag({
    super.key,
    this.tagText = "",
  });

  final String tagText;

  @override
  State<StatefulWidget> createState() => _BlogTagState();

}

class _BlogTagState extends State<BlogTag> {

  @override
  Widget build(BuildContext context) {
    return (
      Container(
          height: 34,
          padding: const EdgeInsets.all(4),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0),
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF00E5FF)),
              ),
          ),
          child: Center (
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text(
                      widget.tagText,
                      textAlign: TextAlign.center,
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
          )
      )
    );
  }
}
