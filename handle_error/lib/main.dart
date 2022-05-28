import 'package:flutter/material.dart';
import 'package:handle_error/post_change_notifier.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => PostChangeNotifier(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Handling"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Consumer<PostChangeNotifier>(
              builder: (BuildContext context, PostChangeNotifier notifier,
                  Widget? child) {
                if (notifier.state == NotifierState.initial) {
                  return Text('Press the button 👇');
                } else if (notifier.state == NotifierState.loading) {
                  return CircularProgressIndicator();
                } else {
                  return notifier.post.fold(
                    (failure) => Text(failure.toString()),
                    (post) => Text(post.toString()),
                  );
                }
              },
            ),
            ElevatedButton(
              child: Text('Get Post'),
              onPressed: () =>
                  Provider.of<PostChangeNotifier>(context).getOnePost(),
            ),
          ],
        ),
      ),
    );
  }
}
