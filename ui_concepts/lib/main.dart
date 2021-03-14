import 'package:flutter/material.dart';
import 'package:ui_concepts/src/meditation.dart';
import 'package:ui_concepts/src/netflix/home.dart';
import 'package:ui_concepts/src/sidebar.dart';
import 'package:ui_concepts/src/stacked_item_listview.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(UIConcepts());
}

class UIConcepts extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('UI Concepts'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      ListTile(
        title: Text('Netflix'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NetflixHome(),
            ),
          );
        },
      ),
      ListTile(
        title: Text('Meditation'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Meditation(),
            ),
          );
        },
      ),
      ListTile(
        title: Text('SideBar'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SideBar(),
            ),
          );
        },
      ),
      ListTile(
        title: Text('StackedItemListView'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StackedItemListView(),
            ),
          );
        },
      ),
    ];
    return ListView.separated(
      itemCount: widgets.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) => widgets[index],
    );
  }
}
