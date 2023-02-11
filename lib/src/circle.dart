
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const circleDiameter = 10.0;


class Circle extends StatefulWidget {
  const Circle({super.key, required this.onDrag, required this.cursor});
  final SystemMouseCursor cursor;
  final Function onDrag;

  @override
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
        child: Container(
          width: circleDiameter,
          height: circleDiameter,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 243, 100).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
