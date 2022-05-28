import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_widgets/widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog({
    required this.title,
    required this.content,
    this.cancelText = '',
    required this.confirmText,
  });

  final Widget title;
  final Widget content;
  final String cancelText;
  final String confirmText;

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: _actions(
        context,
        cancelText.toUpperCase(),
        confirmText.toUpperCase(),
      ),
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: _actions(context, cancelText, confirmText),
    );
  }

  List<Widget> _actions(
      BuildContext context, String cancelText, String confirmText) {
    var actions = <Widget>[];
    actions.add(
      PlatformAlertDialogAction(
        child: Text(cancelText),
        onPressed: () => _dismiss(context, false),
      ),
    );
    actions.add(
      PlatformAlertDialogAction(
        child: Text(confirmText),
        onPressed: () => _dismiss(context, true),
      ),
    );
    return actions;
  }

  Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !Platform.isIOS,
      builder: (context) => this,
    );
    return Future.value(result ?? false);
  }

  void _dismiss(BuildContext context, bool value) {
    Navigator.of(context, rootNavigator: true).pop(value);
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({required this.child, required this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  FlatButton buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  CupertinoDialogAction buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }
}
