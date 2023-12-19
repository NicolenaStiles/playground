import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package/../../common/BacklitText.dart';
import 'package/../../common/BacklitDivider.dart';

import 'package/../../common/center_structure_frame.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 

      appBar: AppBar ( 
        title: const Text('About Page'),
      ),
      body: Center(
        child: CenterStructureFrame(),
        ),
    );
  }
}

