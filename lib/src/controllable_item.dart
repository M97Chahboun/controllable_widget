import 'dart:math';

import 'package:controllable_widget/src/circle.dart';
import 'package:flutter/material.dart';

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
  final void Function({required Offset offset, required Size size}) onUpdate;
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
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, widget.height));
              setState(() {});
            },
            child: widget.child,
          ),
        ),
        // top left
        Positioned(
          top: widget.top - circleDiameter / 2,
          left: widget.left - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeUpLeft,
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
                  offset: Offset(widget.left, widget.top),
                  size: Size(newWidth, newHeight));
            },
          ),
        ),
        // top middle
        Positioned(
          top: widget.top - circleDiameter / 2,
          left: widget.left + widget.width / 2 - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeUp,
            onDrag: (dx, dy) {
              var newHeight = widget.height - dy;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.top = widget.top + dy;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, newHeight));
            },
          ),
        ),
        // top right
        Positioned(
          top: widget.top - circleDiameter / 2,
          left: widget.left + widget.width - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeUpRight,
            onDrag: (dx, dy) {
              var newHeight = widget.height - dy;
              var newWidth = widget.width + dx;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.top = widget.top + dy;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, newHeight));
            },
          ),
        ),
        // center right
        Positioned(
          top: widget.top + widget.height / 2 - circleDiameter / 2,
          left: widget.left + widget.width - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeRight,
            onDrag: (dx, dy) {
              var newWidth = widget.width + dx;
              setState(() {
                widget.width = newWidth > 0 ? newWidth : 0;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(newWidth, widget.height));
            },
          ),
        ),
        // bottom right
        Positioned(
          top: widget.top + widget.height - circleDiameter / 2,
          left: widget.left + widget.width - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeDownRight,
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;
              var newWidth = widget.width + dx;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, newHeight));
            },
          ),
        ),
        // bottom center
        Positioned(
          top: widget.top + widget.height - circleDiameter / 2,
          left: widget.left + widget.width / 2 - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeDown,
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, newHeight));
            },
          ),
        ),
        // bottom left
        Positioned(
          top: widget.top + widget.height - circleDiameter / 2,
          left: widget.left - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeDownLeft,
            onDrag: (dx, dy) {
              var newHeight = widget.height + dy;
              var newWidth = widget.width - dx;
              setState(() {
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.left = widget.left + dx;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(widget.width, newHeight));
            },
          ),
        ),
        //left center
        Positioned(
          top: widget.top + widget.height / 2 - circleDiameter / 2,
          left: widget.left - circleDiameter / 2,
          child: Circle(
            cursor: SystemMouseCursors.resizeLeft,
            onDrag: (dx, dy) {
              var newWidth = widget.width - dx;
              setState(() {
                widget.width = newWidth > 0 ? newWidth : 0;
                widget.left = widget.left + dx;
              });
              widget.onUpdate(
                  offset: Offset(widget.left, widget.top),
                  size: Size(newWidth, widget.height));
            },
          ),
        ),
      ],
    );
  }
}
