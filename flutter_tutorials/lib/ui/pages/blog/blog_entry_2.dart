import 'package:flutter/material.dart';

class BlogEntry2 extends StatefulWidget {
  const BlogEntry2({ 
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

class _BlogEntryState extends State<BlogEntry2> {
  @override 
  Widget build(BuildContext context) {
    return (
Container(
    width: 1876,
    height: 150,
    padding: const EdgeInsets.all(2),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF0F6B79)),
        ),
    ),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(
                            child: Container(
                                height: 34,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            const SizedBox(height: 10),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(
                            child: Container(
                                height: 34,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        Expanded(
                                            child: SizedBox(
                                                child: Text(
                                                    'This is a test subheading that is a bit longer.',
                                                    style: TextStyle(
                                                        color: Color(0xFFB9B9B9),
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
                    ],
                ),
            ),
            const SizedBox(height: 10),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF00E5FF)),
                                ),
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Text(
                                        'Test',
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
                        ),
                    ],
                ),
            ),
        ],
    ),
)
);
}
}
