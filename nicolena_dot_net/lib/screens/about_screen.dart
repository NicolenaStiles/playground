import 'package:flutter/material.dart';
import '../common/core_border.dart';
import '../common/nav_header.dart';

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

            // Body
            Container( 
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 6,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF00E5FF),
                  ),
                ),
              ),
              child: Center( 
                child: Column( 
                  children: [
                  ]
                )
              )
            )
          ],
        ),
    );
  }
}
