import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';

import 'movie.dart';

final List<String> genres = const [
  'HORROR',
  'THRILLER',
  'ROMANTIK',
  'ACTION',
  'COMEDY',
  'SCI-FI',
];

final List<String> movies = const [
  'assets/movie1.jpg',
  'assets/movie2.jpg',
  'assets/movie3.jpg',
  'assets/movie4.jpg',
  'assets/movie5.jpg',
  'assets/movie6.jpg',
];

class NetflixHome extends StatefulWidget {
  const NetflixHome({Key key}) : super(key: key);

  @override
  _NetflixHomeState createState() => _NetflixHomeState();
}

class _NetflixHomeState extends State<NetflixHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          _getNavBar(),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 50),
                _getTabBar(),
                SizedBox(height: 20),
                _getCarousel(context),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  height: 50,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        color: Colors.red,
                        child: Text(
                          genres[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Trending', style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                Container(
                  height: 190,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(movies[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Trailer', style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                Container(
                  height: 190,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(movies[movies.length - index - 1]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Carousel _getCarousel(BuildContext context) {
    return Carousel(
      height: 350,
      type: 'slideswiper',
      showIndicator: false,
      arrowColor: Colors.transparent,
      axis: Axis.horizontal,
      children: List.generate(
        movies.length,
        (index) => Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage()));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(movies[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width - 60,
    );
  }

  Row _getTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Films", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              CircleAvatar(radius: 3, backgroundColor: Colors.red),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Series", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("My List", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Container _getNavBar() {
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
