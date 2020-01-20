import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const Header({Key key, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: Text(
        title ?? "FlutterShare",
        style: TextStyle(
          color: Colors.white,
          fontFamily: title == null ? "Signatra" : "",
          fontSize: title == null ? 50 : 22,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
