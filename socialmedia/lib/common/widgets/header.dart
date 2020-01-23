import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const Header({Key key, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: actions,
      title: Text(
        title ?? "FlutterShare",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Signatra",
          fontSize: 50,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
