import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Circle extends StatefulWidget {
  const Circle({
    super.key,
    required this.onDrag,
    required this.cursor,
    required this.circleSize,
    this.onEnd,
  });
  final SystemMouseCursor cursor;
  final Function onDrag;
  final Function(DragEndDetails)? onEnd;
  final double circleSize;

  @override
  // ignore: library_private_types_in_public_api
  _BallState createState() => _BallState();
}

class _BallState extends State<Circle> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      child: GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        onPanEnd: widget.onEnd,
        child: Container(
          width: widget.circleSize,
          height: widget.circleSize,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 243, 100).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
