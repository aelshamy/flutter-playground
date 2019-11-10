import 'package:flutter/material.dart';

import 'animated_bg.dart';
import 'item.dart';
import 'item_card.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _controller = new ScrollController();

  List<ListCard> get _cards => items.map((Item _item) => ListCard(_item)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          AnimatedBackground(controller: _controller),
          Center(
            child: ListView(controller: _controller, children: _cards),
          ),
        ],
      ),
    );
  }
}
