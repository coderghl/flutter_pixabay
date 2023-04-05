import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExtended on BuildContext {
  void showMessage(String message,
      {Duration duration = const Duration(milliseconds: 2000)}) {
    if (mounted) {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
        ),
      );
    }
  }

  void push(Widget target) {
    Navigator.push(this, CupertinoPageRoute(builder: (context) => target));
  }

  void pop() {
    Navigator.pop(this);
  }
}
