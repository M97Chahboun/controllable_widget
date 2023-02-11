import 'dart:math';

import 'package:flutter/material.dart';

const ballDiameter = 10.0;

// ignore: must_be_immutable
class ControllableWidget extends StatefulWidget {
  double height, width, left, top;

  ControllableWidget(
      {super.key,
      required this.child,
      required this.top,
      required this.height,
      required this.width,
      required this.left,
      required this.onUpdate});
  final Function(Offset, Size) onUpdate;
  final Widget child;

  @override
  State<ControllableWidget> createState() => _ControllableWidgetState();
}

class _ControllableWidgetState extends State<ControllableWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: widget.top,
          left: widget.left,
          height: widget.height,
          width: widget.width,
          child: GestureDetector(
            onPanUpdate: (details) {
              widget.left = max(0, widget.left + details.delta.dx);
              widget.top = max(0, widget.top + details.delta.dy);
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, widget.height));
              setState(() {});
            },
            child: widget.child,
          ),
        ),
        // top left
        Positioned(
          top: widget.top - ballDiameter / 2,
          left: widget.left - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height - dy;
              var newWidth = widget.width - dx;
              setState(() {
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.top = widget.top + dy;
                widget.left = widget.left + dx;
              });
              widget.onUpdate(
                  Offset(widget.left, widget.top), Size(newWidth, newHeight));
            },
          ),
        ),
        // top middle
        Positioned(
          top: widget.top - ballDiameter / 2,
          left: widget.left + widget.width / 2 - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height - dy;

              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.top = widget.top + dy;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, newHeight));
            },
          ),
        ),
        // top right
        Positioned(
          top: widget.top - ballDiameter / 2,
          left: widget.left + widget.width - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height - dy;
              var newWidth = widget.width + dx;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.top = widget.top + dy;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, newHeight));
            },
          ),
        ),
        // center right
        Positioned(
          top: widget.top + widget.height / 2 - ballDiameter / 2,
          left: widget.left + widget.width - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newWidth = widget.width + dx;

              setState(() {
                widget.width = newWidth > 0 ? newWidth : 0;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(newWidth, widget.height));
            },
          ),
        ),
        // bottom right
        Positioned(
          top: widget.top + widget.height - ballDiameter / 2,
          left: widget.left + widget.width - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;
              var newWidth = widget.width + dx;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, newHeight));
            },
          ),
        ),
        // bottom center
        Positioned(
          top: widget.top + widget.height - ballDiameter / 2,
          left: widget.left + widget.width / 2 - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;

              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, newHeight));
            },
          ),
        ),
        // bottom left
        Positioned(
          top: widget.top + widget.height - ballDiameter / 2,
          left: widget.left - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;
              var newWidth = widget.width - dx;

              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.left = widget.left + dx;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(widget.width, newHeight));
            },
          ),
        ),
        //left center
        Positioned(
          top: widget.top + widget.height / 2 - ballDiameter / 2,
          left: widget.left - ballDiameter / 2,
          child: Ball(
            onDrag: (dx, dy) {
              var newWidth = widget.width - dx;

              setState(() {
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.left = widget.left + dx;
              });
              widget.onUpdate(Offset(widget.left, widget.top),
                  Size(newWidth, widget.height));
            },
          ),
        ),
      ],
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({Key? key, required this.onDrag});

  final Function onDrag;

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
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
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 243, 100).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
