import 'package:flutter/material.dart';

class SubheadingWebText extends StatefulWidget {
  const SubheadingWebText({ 
    super.key,
    this.text = "",
  });

  final String text;

  @override
  State<StatefulWidget> createState() => _SubheadingWebTextState();

}

class _SubheadingWebTextState extends State<SubheadingWebText> {

  @override 
  Widget build(BuildContext context) {
    return ( 
      Text(
          widget.text,
          textAlign: TextAlign.left,
          style: const TextStyle(              
              color: Color(0xFFB9B9B9),
              fontSize: 21,
              fontFamily: 'ProFont IIx Nerd Font Mono',
              fontWeight: FontWeight.w400,
              height: 0,
          ),
      )
    );
  }
}
