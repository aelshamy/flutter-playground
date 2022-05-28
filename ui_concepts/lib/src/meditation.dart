import 'package:flutter/material.dart';

class Meditation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomBody(),
          // CustomAppbar(),
          // NavBar(),
        ],
      ),
    );
  }
}

class CustomBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Section(
              headline: 'Meditation',
              description: 'discover happiness',
              img: AssetImage('assets/dessert.jpg'),
            ),
            Section(
              headline: 'Sensations',
              description: 'feel the moment',
              img: AssetImage('assets/galaxy.jpg'),
            ),
          ],
        ),
        Center(
          child: ClipPath(
            clipper: MidClipper(),
            child: Section(
              headline: 'Daydream',
              description: 'go beyond the form',
              img: AssetImage('assets/beach.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}

class MidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(0, sh * 0.3, sw, sh * 0.2, sw, sh * 0.45);
    path.lineTo(sw, sh);
    path.cubicTo(sw, sh * 0.7, 0, sh * 0.8, 0, sh * 0.55);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Section extends StatelessWidget {
  final String headline;
  final String description;
  final ImageProvider img;

  const Section({
    required this.headline,
    required this.description,
    required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: img,
        ),
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: headline,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: '\n$description',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
