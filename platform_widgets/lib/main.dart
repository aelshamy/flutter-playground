import 'package:flutter/material.dart';
import 'package:platform_widgets/data.dart';
import 'package:platform_widgets/notifiers.dart';
import 'package:platform_widgets/widgets/custom_dialog_box.dart';
import 'package:platform_widgets/widgets/platform_alert_dialog.dart';
import 'package:platform_widgets/widgets/platform_toggle_tile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SingleNotifier>(
          create: (_) => SingleNotifier(),
        ),
        ChangeNotifierProvider<MultipleNotifier>(
          create: (_) => MultipleNotifier([]),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dialog',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: Center(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('AlertDialog'),
                onTap: () => _showMessageDialog(context),
              ),
              ListTile(
                title: Text('Single choice Dialog'),
                onTap: () => _showSingleChoiceDialog(context),
              ),
              ListTile(
                title: Text('Multiple choice Dialog'),
                onTap: () => _showMultiChoiceDialog(context),
              ),
              ListTile(
                title: Text('Text field Dialog'),
                onTap: () => _showAddNoteDialog(context),
              ),
              ListTile(
                title: Text('Open Custom Dialog'),
                onTap: () => _showCustomDialog(context),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }

  _showMessageDialog(BuildContext context) => PlatformAlertDialog(
        title: Text("Are you sure"),
        content: Text("Do you want to delete these items?"),
        confirmText: "Yes",
      ).show(context);

  _showSingleChoiceDialog(BuildContext context) {
    final _singleNotifier = Provider.of<SingleNotifier>(context, listen: false);
    final result = PlatformAlertDialog(
      title: Text("Select one country"),
      content: SingleChildScrollView(
        child: Column(
          children: countries
              .map(
                (e) => Material(
                  type: MaterialType.transparency,
                  child: RadioListTile(
                    title: Text(e),
                    value: e,
                    groupValue: _singleNotifier.currentCountry,
                    selected: _singleNotifier.currentCountry == e,
                    onChanged: (value) {
                      if (value != _singleNotifier.currentCountry) {
                        _singleNotifier.updateCountry(value);
                      }
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
      confirmText: "Yes",
    ).show(context);
  }

  _showMultiChoiceDialog(BuildContext context) {
    final _multipleNotifier =
        Provider.of<MultipleNotifier>(context, listen: false);
    final result = PlatformAlertDialog(
      title: Text("Select one country or many countries"),
      content: Material(
        type: MaterialType.transparency,
        child: SingleChildScrollView(
          child: Column(
            children: countries
                .map(
                  (e) => PlatformToggleTile(
                    title: Text(e),
                    onChanged: (value) {
                      value
                          ? _multipleNotifier.addItem(e)
                          : _multipleNotifier.removeItem(e);
                    },
                    value: _multipleNotifier.itemExists(e),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      confirmText: "Yes",
    ).show(context);
  }

  _showAddNoteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add your note"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your note',
                        icon: Icon(Icons.note_add),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  _showCustomDialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: "Custom Dialog Demo",
          descriptions:
              "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
          text: "Yes",
        );
      });
}
