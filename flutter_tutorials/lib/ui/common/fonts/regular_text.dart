import 'package:flutter/material.dart';

class RegularWebText extends StatefulWidget {
  const RegularWebText({ 
    super.key,
    this.text = "",
  });

  final String text;

  @override
  State<StatefulWidget> createState() => _RegularWebTextState();

}

class _RegularWebTextState extends State<RegularWebText> {

  @override 
  Widget build(BuildContext context) {
    return ( 
      Text(
          widget.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontFamily: 'ProFont IIx Nerd Font Mono',
              fontWeight: FontWeight.w400,
              height: 0,
          ),
      )
    );
  }
}
