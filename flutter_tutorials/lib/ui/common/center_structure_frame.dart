
import 'package:flutter/material.dart';

class CenterStructureFrame extends StatelessWidget {

  const CenterStructureFrame ({
      super.key, 
      });

  @override
  Widget build(BuildContext context) {

      return Container(
        constraints: BoxConstraints(minWidth: 375, maxWidth: 1024),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            color: Colors.black.withOpacity(1),
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF00B8D4)),
            ),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Expanded(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: Color(0xFF00E5FF)),
                            ),
                        ),
                    ),
                ),
            ],
        ),
      );
  }
}
