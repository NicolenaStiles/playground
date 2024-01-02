import 'package:flutter/material.dart';

import '../../common/core_border.dart';
import '../../common/nav_header.dart';
import '../../common/body_border.dart';

class ContactScreen extends StatefulWidget {

  const ContactScreen({
    super.key,
  });

  @override 
  State<StatefulWidget> createState() => _ContactScreenState();

}

class _ContactScreenState extends State<ContactScreen> {

  @override
  Widget build(BuildContext context) {
    return CoreBorder(
        content: Column ( 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Header
            NavHeader(),
      
            // spacing/padding
            const SizedBox(
              height: 18,
            ),

            BodyBorder(
              content: Center( 
                child: Column( 
                  children: [
                    Text('Hello this is the Contact page!'),
                  ]
                )
              )
            )

          ],
        ),
    );
  }
}
