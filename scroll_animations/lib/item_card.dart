import 'package:flutter/material.dart';

import 'item.dart';

class ListCard extends StatelessWidget {
  ListCard(this.item);
  final Item item;

  static final Shadow _shadow = Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Colors.white70, shadows: [_shadow]);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      color: item.color.withOpacity(.7),
      child: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(item.name, style: _style.copyWith(fontSize: 64)),
                Icon(item.icon, color: Colors.white70, size: 72),
              ],
            ),
            Center(child: Text(item.description, style: _style.copyWith(fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
