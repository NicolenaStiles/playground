import 'package:flutter/material.dart';

import '../../common/backlit_divider.dart';
import '../../common/backlit_text.dart';

class HomepageScreen extends StatelessWidget {

  const HomepageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'NICOLENA DOT NET',
           style: Theme.of(context).textTheme.displaySmall,
        ),


        const Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            BacklitText(textEntry: 'ABOUT', 
                        fontSize: 24,
                        isSelectable: true,
                        route: '/about'),

            BacklitDivider(),

            BacklitText(textEntry: 'BLOG', 
                        fontSize: 24,
                        isSelectable: true,
                        route: '/blog'),

            BacklitDivider(),

            BacklitText(textEntry: 'CONTACT', 
                        fontSize: 24,
                        isSelectable: true,
                        route: '/contact'),

          ],
        ),
      ],
    );
  }
}
