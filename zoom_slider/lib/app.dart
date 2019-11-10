import 'package:flutter/material.dart';
import 'dart:math';
import 'package:zoom_slider/config.dart';
import 'package:zoom_slider/circle_image_container.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Zoom Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double viewPortFraction = 0.5;

  PageController pageController;

  int currentPage = 2;
  double page = 2.0;

  List<Map<String, String>> listOfItems = [
    {'image': "assets/avatar.png", 'name': "Richmond"},
    {'image': "assets/avatar.png", 'name': "Roy"},
    {'image': "assets/avatar.png", 'name': "Moss"},
    {'image': "assets/avatar.png", 'name': "Douglas"},
    {'image': "assets/avatar.png", 'name': "Jen"}
  ];

  void initState() {
    pageController = PageController(initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: PAGER_HEIGHT,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    page = pageController.page;
                  });
                }
              },
              child: PageView.builder(
                onPageChanged: (pos) {
                  setState(() {
                    currentPage = pos;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: listOfItems.length,
                itemBuilder: (context, index) {
                  final scale = max(SCALE_FRACTION, (FULL_SCALE - (index - page).abs()) + viewPortFraction);
                  return CircleImageContainer(image: listOfItems[index]['image'], scale: scale);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              listOfItems[currentPage]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
