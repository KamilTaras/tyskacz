import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';


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
  bool _isSwiped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _offsetX += details.primaryDelta!;
          if (_offsetX < 0) {
            _offsetX = 0;
          }
          _isSwiped = _offsetX > 50; // Check if it's swiped more than 50 pixels
        });
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_isSwiped) {
          // Swiped from left to right (right direction)
          widget.onSwipe();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Action performed!')));
        }
        // Reset the offset and swiped flag after the drag ends
        setState(() {
          _offsetX = 0.0;
          _isSwiped = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        color: _isSwiped ? Colors.orange.withOpacity(0.2) : Colors.transparent,
        child: Transform.translate(
          offset: Offset(_offsetX, 0.0),
          child: widget.child,
        ),
      ),
    );
  }
}
