import 'package:flutter/material.dart';

import '../../common/core_border.dart';
import '../../common/nav_header.dart';
import '../../common/body_border.dart';
import '../../common/tab_header.dart';
import 'selectable_blog_entry.dart';

import 'package:parallax_rain/parallax_rain.dart';

class AboutScreen extends StatefulWidget {

  const AboutScreen({
    super.key,
  });

  @override 
  State<StatefulWidget> createState() => _AboutScreenState();

}

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Stack (
          children: <Widget>[

              ParallaxRain( 
                dropColors: [
                  Colors.cyan,
                ],
                trail: true,
                dropFallSpeed: 1,
                numberOfDrops: 100,
              ),

              const CoreBorder(
              content: Column ( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Header
                  NavHeader(),
            
                  // spacing/padding
                  SizedBox(
                    height: 18,
                  ),

                  BodyBorder(
                    content: Center( 
                      child: Column( 
                        children: [
                          TabHeader(tabHeaderText: '//ABOUT'),

                          SelectableBlogEntry(route: 'oops',)

                        ]
                      )
                    )
                  )

                ],
              ),
              ),
        ]
        ),
    );
  }
}
