import 'package:flutter/material.dart';
import 'package:handle_error/post_change_notifier.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Handling"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Consumer<PostChangeNotifier>(
              builder: (BuildContext context, PostChangeNotifier notifier,
                  Widget? child) {
                if (notifier.state == NotifierState.initial) {
                  return const Text('Press the button 👇');
                } else if (notifier.state == NotifierState.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return notifier.post.fold(
                    (failure) => Text(failure.toString()),
                    (post) => Text(post.toString()),
                  );
                }
              },
            ),
            ElevatedButton(
              child: const Text('Get Post'),
              onPressed: () =>
                  Provider.of<PostChangeNotifier>(context).getOnePost(),
            ),
          ],
        ),
      ),
    );
  }
}
