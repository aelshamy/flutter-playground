import 'package:flutter/material.dart';

const subColor = const Color(0xFF1BB5fD);
const mainColor = const Color(0xFF262AAA);
// const mainColor = Colors.black87;

class SideBar extends StatefulWidget {
  const SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  bool _isSidebarOpened;
  Duration _animationDuration = Duration(milliseconds: 500);
  AnimationController _controller;

  @override
  void initState() {
    _isSidebarOpened = false;
    _controller = AnimationController(vsync: this, duration: _animationDuration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: 0,
      bottom: 0,
      left: _isSidebarOpened ? 0 : -screenWidth,
      right: _isSidebarOpened ? 0 : screenWidth - 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: mainColor,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 70),
                    ListTile(
                      title: Text(
                        'Amr Elshamy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
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
                    MenuItem(icon: Icons.shopping_basket, title: "My Orders"),
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
            alignment: Alignment(0, -0.85),
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
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            icon,
            color: subColor,
            size: 30,
          ),
          SizedBox(width: 20),
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
    Path path = Path();
    double width = size.width;
    double height = size.height;

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
