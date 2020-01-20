import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:shapes/clip_shadow.dart';

RandomColor _randomColor = RandomColor();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipShadow(
                    clipper: WaveClipper(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange[700],
                        offset: Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Colors.orange,
                        offset: Offset(0.0, 0.0),
                        spreadRadius: -3.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome to our app',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children:
                            List.generate(50, (int index) => getItem(index))
                                .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        direction: Axis.horizontal,
      ),
    );
  }

  Container getItem(int index) {
    return Container(
      color: _randomColor.randomColor(colorHue: ColorHue.red),
      width: 110,
      height: 110,
      alignment: Alignment.center,
      child: Text(
        "${index + 1}",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
