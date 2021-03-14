import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';

import 'menu.dart';
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

class NetflixHome extends StatelessWidget {
  const NetflixHome({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Menu(),
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
                      Text('Trending',
                          style: TextStyle(fontWeight: FontWeight.w500)),
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
                      Text('Trailer',
                          style: TextStyle(fontWeight: FontWeight.w500)),
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
                            image:
                                AssetImage(movies[movies.length - index - 1]),
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
      initialPage: 0,
      type: 'slideswiper',
      showIndicator: false,
      arrowColor: Colors.transparent,
      axis: Axis.horizontal,
      children: movies
          .map((movie) => Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MoviePage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(movie),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
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
}
