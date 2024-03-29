import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ezsale/core/auth/handlers/facebook/icon.dart';
import 'package:ezsale/core/common/future_action_callback.dart';

class SignInButton extends StatelessWidget {
  SignInButton({@required this.action});

  final FutureActionCallback<BuildContext> action;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      padding: EdgeInsets.all(8.0),
      onPressed: () async => await action(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            width: 70.0,
            child: Icon(
              providerIcon,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: new Center(
              child: Text(
                'Facebook Sign in',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(width: 70.0),
        ],
      ),
    );
  }
}
