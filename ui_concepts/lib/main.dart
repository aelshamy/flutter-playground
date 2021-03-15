import 'package:flutter/material.dart';
import 'package:ui_concepts/src/custom_bottom_sheet.dart';
import 'package:ui_concepts/src/meditation.dart';
import 'package:ui_concepts/src/netflix/home.dart';
import 'package:ui_concepts/src/sidebar.dart';
import 'package:ui_concepts/src/stacked_item_listview.dart';

void main() async {
  runApp(UIConcepts());
}

class UIConcepts extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      ListTile(
        title: Text('Custom Bottom Sheet'),
        onTap: () {
          showModalBottomSheet<int>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return CustomBottomSheet(
                children: [
                  SwitchListTile.adaptive(
                    value: true,
                    title: DefaultTextStyle(
                      child: Text(
                        'Total Task',
                      ),
                      style: theme.textTheme.headline6,
                    ),
                    secondary: Icon(
                      Icons.check_circle_outline,
                      color: theme.iconTheme.color,
                    ),
                    onChanged: (value) {},
                  ),
                  SwitchListTile.adaptive(
                    value: false,
                    title: DefaultTextStyle(
                      child: Text(
                        'Due Soon',
                      ),
                      style: theme.textTheme.headline6,
                    ),
                    secondary: Icon(
                      Icons.inbox,
                      color: theme.iconTheme.color,
                    ),
                    onChanged: (value) {},
                  ),
                  SwitchListTile.adaptive(
                    value: false,
                    title: DefaultTextStyle(
                      child: Text(
                        'Completed',
                      ),
                      style: theme.textTheme.headline6,
                    ),
                    secondary: Icon(
                      Icons.check_circle,
                      color: theme.iconTheme.color,
                    ),
                    onChanged: (value) {},
                  ),
                  SwitchListTile.adaptive(
                    value: false,
                    title: DefaultTextStyle(
                      child: Text(
                        'Working On',
                      ),
                      style: theme.textTheme.headline6,
                    ),
                    secondary: Icon(
                      Icons.flag,
                      color: theme.iconTheme.color,
                    ),
                    onChanged: (value) {},
                  ),
                ],
              );
            },
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Concepts'),
      ),
      body: ListView.separated(
        itemCount: widgets.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => widgets[index],
      ),
    );
  }
}
