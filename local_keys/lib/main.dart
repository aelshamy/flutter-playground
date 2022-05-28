import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Cat {
  String imageSrc;
  String name;
  int age;
  int votes;

  Cat(this.imageSrc, this.name, this.age, this.votes);

  operator ==(other) => (other is Cat) && (imageSrc == other.imageSrc);
  int get hashCode => imageSrc.hashCode;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Voting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cat Voting Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> catNames = [
    "Tom",
    "Oliver",
    "Ginger",
    "Pontouf",
    "Madison",
    "Bubblita",
    "Bubbles",
  ];

  Random _random = Random();
  List<Cat> _cats = [];

  int next(int min, int max) => min + _random.nextInt(max - min);

  _MyHomePageState() : super() {
    for (int i = 200; i < 300; i += 10) {
      _cats.add(
        Cat("http://placekitten.com/200/$i", catNames[next(0, 6)], next(1, 32),
            0),
      );
    }
  }

  void _shuffle() {
    setState(() {
      _cats.shuffle(_random);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Voting'),
      ),
      body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return GridView.builder(
          itemCount: _cats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CatTile(_cats[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        tooltip: 'Try more grid options',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CatTile extends StatefulWidget {
  final Cat cat;

  CatTile(this.cat) : super(key: ValueKey(cat.imageSrc));

  @override
  _CatTileState createState() => _CatTileState();
}

class _CatTileState extends State<CatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GridTile(
        header: GridTileBar(
          title: Text(
            "${widget.cat.name} ${widget.cat.age} years old",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        ),
        footer: GridTileBar(
          title: Text(
            widget.cat.votes == 0 ? "No Votes" : "${widget.cat.votes} votes",
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        child: Image.network(widget.cat.imageSrc, fit: BoxFit.cover),
      ),
      onTap: () => _vote(),
    );
  }

  _vote() {
    setState(() => widget.cat.votes++);
  }
}
