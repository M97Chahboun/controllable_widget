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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
            height: 60.0,
            width: 60.0,
            top: 0,
            left: 0,
            onUpdate: (Offset offset, Size size) {
              print("Offset:$offset");
              print("Size:$size");
            },
            child: ColoredBox(
                color: Colors.blue, child: Center(child: Text("Item $index"))),
          );
        })),
      ),
    );
  }
}
