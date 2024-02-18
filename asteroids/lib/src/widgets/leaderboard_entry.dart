import 'package:flutter/material.dart';

class LeaderboardEntry extends StatefulWidget {

  const LeaderboardEntry({ 
    super.key,
    required this.idx,
    required this.score,
    required this.initials,
  });

  final int idx;
  final int score;
  final String initials;

  @override
  State<LeaderboardEntry> createState() => _LeaderboardEntryState();
}

class _LeaderboardEntryState extends State<LeaderboardEntry> {

  TextStyle _buttonTextStyle = const TextStyle();

  // have to set things here, because context is not availible in 'initState'
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    if (width < 414) {
      _buttonTextStyle = Theme.of(context).textTheme.bodySmall!;
    } else  {
      _buttonTextStyle = Theme.of(context).textTheme.titleMedium!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // idx
          Text( 
            '${widget.idx}.',
            style: _buttonTextStyle),

          // score 
          Text( 
            '${widget.score}',
            style: _buttonTextStyle),

          // initals 
          Text( 
            widget.initials,
            style: _buttonTextStyle),
        ],
      ),
    );
  }

}
