import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<Null> showErrorDialog(BuildContext context, String message) {
  return showDialog<Null>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return PlatformAlertDialog(
        title: Text('Oops'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message ?? 'As unknown error occured'),
            ],
          ),
        ),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  );
}
