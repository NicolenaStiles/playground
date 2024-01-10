import 'package:flutter/material.dart';
import 'core_border.dart';

class EntryScreen extends StatefulWidget {

  const EntryScreen({
    super.key,
    this.title = "",
    this.uRL = "",
  });

  final String title;
  final String uRL;

  @override 
  State<StatefulWidget> createState() => _EntryScreenState();

}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return CoreBorder(
      content: Center ( 
        child: Text(widget.title),
      )
    );
  }
}
