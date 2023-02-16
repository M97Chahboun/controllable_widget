Package for make widget controllable


![Alt Text](/example.gif)
## Features

- [x] Move widget (onMove & onEndMove)
- [x] Resize widget (onResize & onEndResize)
- [x] Resize & Move (onUpdate & onEndUpdate)
- [ ] Rotate widget (onRotate & onEndRotate)
- [ ] Add max/min size
- [ ] Add max/min offset
- [ ] Add max/min rotate

## Getting started

It's required to use ControllableWidget inside of Stack widget

## Usage

```dart
ControllableWidget(
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
		color: Colors.blue,
		child: Center(
		child: Text("Item $index"),
		),
	),
	);
```
Full [`/example`](/example)

Finally, feel free to contribute or suggest any idea 💡