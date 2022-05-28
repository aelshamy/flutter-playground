import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> stack1 = [Colors.red, Colors.blue];
  List<Color> stack2 = [Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStack(stack1),
            buildStack(stack2),
          ],
        ),
      ),
    );
  }

  buildStack(List<Color> stack) {
    return DragTarget(
      onAccept: (Color data) {
        setState(() {
          if (stack.isNotEmpty && data == stack.last) return;
          stack.add(data);
          final otherStack = [stack1, stack2]..remove(stack);
          for (final stack in otherStack) {
            stack.remove(data);
          }
        });
      },
      builder: (BuildContext context, List<Object?> candidateData,
              List<dynamic> rejectedData) =>
          Stack(
        children: [
          Container(
            color: Colors.black,
            width: 200,
            height: 200,
            child: const Center(
              child: Text(
                'Empty',
              ),
            ),
          ),
          ...stack.map(buildStackItem).toList(),
        ],
      ),
    );
  }

  Widget buildStackItem(Color color) {
    var colorBox = Container(
      color: color,
      width: 200,
      height: 200,
    );
    return Draggable(
      data: color,
      feedback: colorBox,
      childWhenDragging: const SizedBox(width: 200, height: 200),
      child: colorBox,
    );
  }
}
