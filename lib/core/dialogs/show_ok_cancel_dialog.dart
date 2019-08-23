import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<Null> showOkCancelDialog(
    VoidCallback onOk,
    VoidCallback onCancel,
    {
      @required String message,
      @required String caption,
      @required BuildContext context
    }
  ) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text(caption),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText('Cancel'),
              onPressed: () => onCancel(),
            ),
            PlatformDialogAction(
              child: Text('OK'),
              onPressed: () => onOk(),
            ),
          ],
        );
      }
    );
  }
