import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_undo_action/count_down.dart';

class Flushbars {
  static Flushbar undo({
    required String message,
    required VoidCallback onUndo,
    Duration duration = const Duration(seconds: 5),
  }) {
    return Flushbar<void>(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: duration,
      icon: CountDownWidget(
        duration: duration,
      ),
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      mainButton: TextButton(
        onPressed: onUndo,
        child: const Text('Undo'),
      ),
    );
  }
}
