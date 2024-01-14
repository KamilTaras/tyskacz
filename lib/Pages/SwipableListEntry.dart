import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipableListEntry extends StatefulWidget {
  SwipableListEntry({
    super.key,
    required this.child,
    required this.onTap,
    required this.onSwipe,
  });

  final VoidCallback onTap;
  final VoidCallback onSwipe;
  final child;
  @override
  _SwipableListEntryState createState() => _SwipableListEntryState();
}

class _SwipableListEntryState extends State<SwipableListEntry> {
  double _offsetX = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _offsetX += details.primaryDelta!;
          if(_offsetX<0) {
            _offsetX=0;
          }
        });
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_offsetX > 50) {
          // Swiped from left to right (right direction)
          widget.onSwipe();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Action performed!')));
        }
        // Reset the offset after the drag ends
        setState(() {
          _offsetX = 0.0;
        });
      },
      onTap: widget.onTap,
      child: Transform.translate(
        offset: Offset(_offsetX, 0.0),
        child: widget.child,
      ),
    );
  }
}
