import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Floating Action Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated Floating Action Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const double _iconSize = 30;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _duration = const Duration(milliseconds: 500);
  late final AnimationController _controller;
  late final Animation<double> _rotationAngle;
  late final Animation<Color?> _centerIconBackgroundColor;
  late final Animation<Color?> _centerIconForegroundColor;
  late final Animation<double> _bottomBarActionMenuHight;
  late final CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _duration,
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _rotationAngle = Tween<double>(begin: 1, end: 4).animate(_curvedAnimation);
    _centerIconBackgroundColor =
        ColorTween(begin: Colors.red, end: Colors.black12)
            .animate(_curvedAnimation);
    _centerIconForegroundColor =
        ColorTween(begin: Colors.white, end: Colors.black)
            .animate(_curvedAnimation);
    _bottomBarActionMenuHight =
        Tween<double>(begin: -50, end: 90).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,
              BottomBarActionMenu(
                bottom: _bottomBarActionMenuHight.value,
                controller: _curvedAnimation,
              ),
              ABottomAppBar(
                onCenterButtonTap: _onCenterButtonTap,
                rotationAngle: _rotationAngle.value,
                centerIconBackgroundColor: _centerIconBackgroundColor.value,
                centerIconForegroundColor: _centerIconForegroundColor.value,
              ),
            ],
          );
        },
        animation: _controller,
        child: const AGrid(),
      ),
    );
  }

  void _onCenterButtonTap() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }
}

class BottomBarActionMenu extends StatelessWidget {
  final double bottom;
  final CurvedAnimation controller;
  const BottomBarActionMenu({
    Key? key,
    required this.bottom,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 120,
      left: 0,
      right: 0,
      bottom: bottom,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.35),
              Colors.white.withOpacity(0.005),
            ],
            stops: const [0.55, 0.65, 0.75, 0.85, 0.99],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomMenuActionsItem(
              title: 'Add Places',
              icon: Icons.location_on,
              position: Tween<Offset>(
                begin: const Offset(0, 2),
                end: const Offset(0, 0),
              ).animate(controller),
            ),
            BottomMenuActionsItem(
              title: 'Create List',
              icon: Icons.view_list_rounded,
              position: Tween<Offset>(
                begin: const Offset(0, 7),
                end: const Offset(0, 0),
              ).animate(controller),
            ),
            BottomMenuActionsItem(
              title: 'Add Friend',
              icon: Icons.person_add_alt_1_rounded,
              position: Tween<Offset>(
                begin: const Offset(0, 12),
                end: const Offset(0, 0),
              ).animate(controller),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMenuActionsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Animation<Offset> position;

  const BottomMenuActionsItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ABottomAppBar extends StatelessWidget {
  final double rotationAngle;
  final Color? centerIconBackgroundColor;
  final Color? centerIconForegroundColor;
  final VoidCallback onCenterButtonTap;

  const ABottomAppBar({
    Key? key,
    required this.rotationAngle,
    required this.centerIconBackgroundColor,
    required this.centerIconForegroundColor,
    required this.onCenterButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 90,
      child: BottomAppBar(
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.assistant_navigation,
              color: Colors.black,
              size: _iconSize,
            ),
            const Icon(
              Icons.map_outlined,
              color: Colors.black,
              size: _iconSize,
            ),
            InkWell(
              onTap: onCenterButtonTap,
              customBorder: const CircleBorder(),
              child: Transform.rotate(
                angle: -pi / rotationAngle,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: centerIconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: centerIconForegroundColor,
                    size: _iconSize,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: _iconSize,
            ),
            const Icon(
              Icons.person_outline_rounded,
              color: Colors.black,
              size: _iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class AGrid extends StatelessWidget {
  const AGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 12,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            width: 300,
            height: 300,
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
