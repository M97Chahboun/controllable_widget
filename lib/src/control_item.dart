import 'dart:math';

import 'package:flutter/material.dart';

import 'circle.dart';

typedef OnMove = void Function(Offset newOffset);
typedef OnResize = void Function(Size newSize);
typedef OnUpdate = void Function(Offset newOffset, Size newSize);

// ignore: must_be_immutable
class ControllableWidget extends StatefulWidget {
  double height, width, left, top;
  static _defaultUpdate(Offset newOffset, Size newSize) {}
  static _defaultOnMove(Offset newOffset) {}
  static _defaultOnResize(Size newSize) {}

  /// Make sure you used it inside of [Stack]
  ControllableWidget(
      {super.key,
      required this.child,
      required this.top,
      required this.height,
      required this.width,
      required this.left,
      this.circleSize = 10.0,
      this.onResize = _defaultOnResize,
      this.onEndResize = _defaultOnResize,
      this.onMove = _defaultOnMove,
      this.onEndMove = _defaultOnMove,
      this.onUpdate = _defaultUpdate,
      this.onEndUpdate = _defaultUpdate});
  final OnResize? onResize;
  final OnResize? onEndResize;
  final OnMove? onMove;
  final OnMove? onEndMove;
  final OnUpdate? onUpdate;
  final OnUpdate? onEndUpdate;
  final double circleSize;
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
            onPanEnd: _onEndMove,
            onPanUpdate: (details) {
              widget.left = max(0, widget.left + details.delta.dx);
              widget.top = max(0, widget.top + details.delta.dy);
              widget.onMove!(Offset(widget.left, widget.top));
              widget.onUpdate!(Offset(widget.left, widget.top),
                  Size(widget.width, widget.height));
              setState(() {});
            },
            child: widget.child,
          ),
        ),
        // top left
        Positioned(
          top: widget.top - widget.circleSize / 2,
          left: widget.left - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeUpLeft,
              onDrag: _topLeft,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // top middle
        Positioned(
          top: widget.top - widget.circleSize / 2,
          left: widget.left + widget.width / 2 - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeUp,
              onDrag: _topCenter,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // top right
        Positioned(
          top: widget.top - widget.circleSize / 2,
          left: widget.left + widget.width - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeUpRight,
              onDrag: _topRight,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // center right
        Positioned(
          top: widget.top + widget.height / 2 - widget.circleSize / 2,
          left: widget.left + widget.width - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeRight,
              onDrag: _centerRight,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // bottom right
        Positioned(
          top: widget.top + widget.height - widget.circleSize / 2,
          left: widget.left + widget.width - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeDownRight,
              onDrag: _bottomRight,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // bottom center
        Positioned(
          top: widget.top + widget.height - widget.circleSize / 2,
          left: widget.left + widget.width / 2 - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeDown,
              onDrag: _bottomCenter,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        // bottom left
        Positioned(
          top: widget.top + widget.height - widget.circleSize / 2,
          left: widget.left - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeDownLeft,
              onDrag: _bottomLeft,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
        //left center
        Positioned(
          top: widget.top + widget.height / 2 - widget.circleSize / 2,
          left: widget.left - widget.circleSize / 2,
          child: Circle(
              cursor: SystemMouseCursors.resizeLeft,
              onDrag: _leftCenter,
              onEnd: _onEndResize,
              circleSize: widget.circleSize),
        ),
      ],
    );
  }

  void _onEndMove(details) {
    widget.onEndMove!(Offset(widget.left, widget.top));
    widget.onEndUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, widget.height));
  }

  void _onEndResize(details) {
    widget.onEndResize!(Size(widget.width, widget.height));
    widget.onEndUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, widget.height));
  }

  void _leftCenter(dx, dy) {
    var newWidth = widget.width - dx;
    setState(() {
      widget.width = newWidth > 0 ? newWidth : 0;
      widget.left = widget.left + dx;
    });
    widget.onResize!(Size(newWidth, widget.height));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(newWidth, widget.height));
  }

  void _bottomLeft(dx, dy) {
    var newHeight = widget.height + dy;
    var newWidth = widget.width - dx;
    setState(() {
      widget.height = newHeight > 0 ? newHeight : 0;
      widget.width = newWidth > 0 ? newWidth : 0;
      widget.left = widget.left + dx;
    });
    widget.onResize!(Size(widget.width, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, newHeight));
  }

  void _bottomCenter(dx, dy) {
    var newHeight = widget.height + dy;
    setState(() {
      widget.height = newHeight > 0 ? newHeight : 0;
    });
    widget.onResize!(Size(widget.width, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, newHeight));
  }

  void _bottomRight(dx, dy) {
    var newHeight = widget.height + dy;
    var newWidth = widget.width + dx;
    setState(() {
      widget.height = newHeight > 0 ? newHeight : 0;
      widget.width = newWidth > 0 ? newWidth : 0;
    });
    widget.onResize!(Size(widget.width, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, newHeight));
  }

  void _centerRight(dx, dy) {
    var newWidth = widget.width + dx;
    setState(() {
      widget.width = newWidth > 0 ? newWidth : 0;
    });
    widget.onResize!(Size(newWidth, widget.height));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(newWidth, widget.height));
  }

  void _topRight(dx, dy) {
    var newHeight = widget.height - dy;
    var newWidth = widget.width + dx;
    setState(() {
      widget.height = newHeight > 0 ? newHeight : 0;
      widget.width = newWidth > 0 ? newWidth : 0;
      widget.top = widget.top + dy;
    });
    widget.onResize!(Size(widget.width, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, newHeight));
  }

  void _topCenter(dx, dy) {
    var newHeight = widget.height - dy;
    setState(() {
      widget.height = newHeight > 0 ? newHeight : 0;
      widget.top = widget.top + dy;
    });
    widget.onResize!(Size(widget.width, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(widget.width, newHeight));
  }

  void _topLeft(dx, dy) {
    var newHeight = widget.height - dy;
    var newWidth = widget.width - dx;
    setState(() {
      widget.width = newWidth > 0 ? newWidth : 0;
      widget.height = newHeight > 0 ? newHeight : 0;
      widget.top = widget.top + dy;
      widget.left = widget.left + dx;
    });
    widget.onResize!(Size(newWidth, newHeight));
    widget.onUpdate!(
        Offset(widget.left, widget.top), Size(newWidth, newHeight));
  }
}
