import 'package:flutter/material.dart';

class StackedItemListView extends StatefulWidget {
  StackedItemListView({Key? key}) : super(key: key);

  @override
  _StackedItemListViewState createState() => _StackedItemListViewState();
}

class _StackedItemListViewState extends State<StackedItemListView> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final duration = Duration(milliseconds: 200);
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        topContainer = controller.offset / 119;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            AnimatedOpacity(
              duration: duration,
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                duration: duration,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : 180,
                child: CategoriesScroller(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: FOOD_DATA.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = FOOD_DATA[index];
                  double scale = 1.0;
                  if (topContainer > 0.5) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return Opacity(
                    opacity: scale,
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.bottomCenter,
                      child: Align(
                        heightFactor: 0.7,
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withAlpha(100),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item["name"],
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      item["brand"],
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$ ${item["price"]}",
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Image.network(item["image"])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.all(20),
            height: 180,
            child: Row(
              children: [
                _getCategoryItem("Most\nFavorites", Colors.orange.shade400),
                _getCategoryItem("Newest", Colors.blue.shade400),
                _getCategoryItem(
                    "Super\nSaving", Colors.lightBlueAccent.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCategoryItem(String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: 180,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "20 Items",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

const FOOD_DATA = <Map<String, dynamic>>[
  {
    "name": "Burger",
    "brand": "Hawkers",
    "price": 2.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Cheese Dip",
    "brand": "Hawkers",
    "price": 4.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Cola",
    "brand": "Macdonald",
    "price": 1.49,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Fries",
    "brand": "Macdonald",
    "price": 2.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Ice Cream",
    "brand": "Ben & Jerry's",
    "price": 9.49,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Noodles",
    "brand": "Hawkers",
    "price": 4.49,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Pizza",
    "brand": "Dominos",
    "price": 17.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Sandwich",
    "brand": "Hawkers",
    "price": 2.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  },
  {
    "name": "Wrap",
    "brand": "Subway",
    "price": 6.99,
    "image": "https://placeimg.com/400/400/tech/grayscale",
  }
];
