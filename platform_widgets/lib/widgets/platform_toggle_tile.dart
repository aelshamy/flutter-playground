import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_widgets/widgets/platform_widget.dart';

class PlatformToggleTile extends PlatformWidget {
  PlatformToggleTile({
    required this.title,
    required this.onChanged,
    required this.value,
  });

  final Widget title;
  final ValueChanged<bool?> onChanged;
  final bool value;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        title: title,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        ),
        onTap: () {
          onChanged(value);
        },
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CheckboxListTile(
      title: title,
      onChanged: onChanged,
      value: value,
    );
  }
}
