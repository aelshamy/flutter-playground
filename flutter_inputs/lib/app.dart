import 'package:flutter/material.dart';
import 'package:flutter_inputs/app_router.dart';

class InputsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Inputs'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(25.0),
        children: <Widget>[
          ListTile(
            title: Text('Checkbox Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'Shows how to use Checkbox and CheckboxListTile',
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.checkboxesRoute);
            },
          ),
          ListTile(
            title: Text('Radio Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'Shows how to use Radio and RadioListTile',
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.radiosRoute);
            },
          ),
          ListTile(
            title: Text('Switch Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Shows how to use Switch and SwitchListTile',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.switchesRoute);
            },
          ),
          ListTile(
            title: Text('Slider Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Shows how to use Slider',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.slidersRoute);
            },
          ),
          ListTile(
            title: Text('DatePicker Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Shows how to use DatePicker',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.datePickerRoute);
            },
          ),
          ListTile(
            title: Text('Custom FormField'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Demonstrate create custom form fields',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.customFormFields);
            },
          ),
          ListTile(
            title: Text('Directionality Examples'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Shows how to use Directionality Widget',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.directionalityRoute);
            },
          ),
        ],
      ),
    );
  }
}
