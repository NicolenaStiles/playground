import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectableBlogEntry extends StatefulWidget {

  const SelectableBlogEntry({ 
    super.key,
    this.route = "",
  });

  final String route;

  @override
  State<StatefulWidget> createState() => _SelectableBlogEntryState();

}

class _SelectableBlogEntryState extends State<SelectableBlogEntry> {
  // define border style here
  BoxDecoration _currBorderDecor = BoxDecoration(
                                    border: Border.all(
                                        color: Colors.cyan,
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  );


  void _swapBorder(bool hover) {
    setState(() {

      if (hover) {
        _currBorderDecor = BoxDecoration(
                                      color: Colors.black ,
                                      border: Border.all(
                                          color: Colors.cyan,
                                          width: 2,
                                          strokeAlign: BorderSide.strokeAlignInside,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.cyan,
                                          blurRadius: 16,
                                          offset: Offset(0,0),
                                        ),
                                      ],
                                    );
      } else {
        _currBorderDecor =  BoxDecoration(
                                  border: Border.all(
                                      color: Colors.cyan,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                );

      }

    });
  }

  @override 
  Widget build(BuildContext context) {
    return( 

      MouseRegion(
        onEnter: (_) {
          _swapBorder(true);
        },

        onExit: (_) {
          _swapBorder(false);
        },

        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: _currBorderDecor,
          child: const Text('Hello I am some text!!'),
        )
      )
    );
  }
}


