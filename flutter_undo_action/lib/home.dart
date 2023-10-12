import 'package:flutter/material.dart';
import 'package:flutter_undo_action/flashbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<String> items;

  @override
  void initState() {
    super.initState();
    items = List.generate(20, (index) => 'ListTile index ${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telegram undo'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                final temp = items.removeAt(index);
                Flushbars.undo(
                  message: "You still have a chance to undo it",
                  duration: const Duration(seconds: 6),
                  onUndo: () {
                    Navigator.of(context).pop();
                    items.insert(index, temp);
                    setState(() {});
                  },
                ).show(context);
              });
            },
            child: Card(
              child: ListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(fontSize: 18),
                ),
                leading: const Icon(Icons.numbers_sharp),
              ),
            ),
          );
        },
      ),
    );
  }
}
