import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Image.asset('assets/logo.png'),
          ),
          Spacer(),
          _menuItem(active: true, icon: Icons.home),
          _menuItem(icon: Icons.search),
          _menuItem(icon: Icons.slideshow),
          _menuItem(icon: Icons.save_alt),
          _menuItem(icon: Icons.menu),
        ],
      ),
    );
  }

  Container _menuItem({bool active = false, IconData icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: active ? Colors.red : Colors.black, width: 3)),
      ),
      child: Icon(
        icon,
        color: active ? Colors.white : Colors.grey,
      ),
    );
  }
}
