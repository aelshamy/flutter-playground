import 'package:flutter/material.dart';
import 'package:staggered_animation/home_page_enter_animation.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required AnimationController controller,
  })  : animation = HomePageEnterAnimation(controller),
        super(key: key);

  final HomePageEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: (BuildContext context, Widget? child) =>
            _buildAnimation(context, child, size),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child, Size size) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              _topBar(animation.barHight.value),
              _circle(size, animation.avatarSize.value),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Opacity(
                opacity: animation.titleOpacity.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0071bf),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Opacity(
                opacity: animation.textOpacity.value,
                child: _form(),
              )
            ],
          ),
        )
      ],
    );
  }

  Container _topBar(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: const Color(0xff0071bf),
          color: Colors.blue
          // image: DecorationImage(
          //   image: AssetImage('assets/banner.gif'),
          //   fit: BoxFit.fitHeight,
          // ),
          ),
    );
  }

  Positioned _circle(Size size, double animationValue) {
    return Positioned(
      top: 200,
      left: size.width / 2 - 50,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue.shade700,
            // image: DecorationImage(
            //   image: AssetImage('assets/logo.png'),
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      ),
    );
  }

  Form _form() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            color: const Color(0xff0071bf),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
