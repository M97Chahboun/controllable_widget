import 'package:controllable_widget/controllable_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  double height = 60.0, width = 60.0, top = 0, left = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controllable Widgets example"),
      ),
      body: Center(
        child: Stack(
            children: List.generate(5, (index) {
          return ControllableWidget(
            height: height,
            width: width,
            left: left,
            top: top,
            onResize: (Size newSize) {
              print("Size:$newSize");
              height = newSize.height;
              width = newSize.width;
            },
            onMove: (newOffset) {
              print("Offset:$newOffset");
              left = newOffset.dx;
              top = newOffset.dy;
            },
            onEndResize: (newSize) {
              print("Size End :$newSize");
              height = newSize.height;
              width = newSize.width;
            },
            onEndMove: (newOffset) {
              print("Offset End :$newOffset");
              left = newOffset.dx;
              top = newOffset.dy;
            },
            child: ColoredBox(
                color: Colors.blue, child: Center(child: Text("Item $index"))),
          );
        })),
      ),
    );
  }
}
