import 'package:flutter/material.dart';

const subColor = Color(0xFF1BB5fD);
const mainColor = Color(0xFF262AAA);
// const mainColor = Colors.black87;

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late bool _isSidebarOpened;
  final Duration _animationDuration = const Duration(milliseconds: 500);
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isSidebarOpened = false;
    _controller =
        AnimationController(vsync: this, duration: _animationDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            brightness: _isSidebarOpened ? Brightness.dark : Brightness.light,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
          ),
          body: Center(
            child: Text('Body'),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: _isSidebarOpened ? 0 : -screenWidth,
          right: _isSidebarOpened ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: mainColor,
                  padding: EdgeInsets.only(top: 70),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Amr Elshamy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          subtitle: const Text(
                            'email@emailprovider.com',
                            style: TextStyle(
                              color: subColor,
                              fontSize: 18,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(
                          height: 40,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(icon: Icons.home, title: "Home"),
                        MenuItem(icon: Icons.person, title: "My Account"),
                        MenuItem(
                            icon: Icons.shopping_basket, title: "My Orders"),
                        MenuItem(icon: Icons.card_giftcard, title: "Wishlists"),
                        Divider(
                          height: 40,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(icon: Icons.settings, title: "Settings"),
                        MenuItem(icon: Icons.exit_to_app, title: "Logout"),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.85),
                child: GestureDetector(
                  onTap: () {
                    final animationStatus = _controller.status;
                    if (animationStatus == AnimationStatus.completed) {
                      // _isSidebarOpened = false;
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }

                    setState(() {
                      _isSidebarOpened = !_isSidebarOpened;
                    });
                  },
                  child: ClipPath(
                    clipper: MenuHandlerClipper(),
                    child: Container(
                      color: mainColor,
                      alignment: Alignment.centerLeft,
                      width: 35,
                      height: 110,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        color: subColor,
                        size: 25,
                        progress: _controller.view,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            icon,
            color: subColor,
            size: 30,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuHandlerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double width = size.width;
    final double height = size.height;

    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
