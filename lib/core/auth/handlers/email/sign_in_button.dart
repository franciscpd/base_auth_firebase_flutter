import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ezsale/core/auth/handlers/email/icon.dart';
import 'package:ezsale/core/common/future_action_callback.dart';
import 'package:ezsale/core/auth/handlers/email/signIn/sign_in_page.dart';

Future signIn(BuildContext context) {
  return Navigator.push(
    context, MaterialPageRoute(builder: (_) => new SignInPassword()),
  );
}

class SignInButton extends StatelessWidget {
  SignInButton({this.action = signIn});

  final FutureActionCallback<BuildContext> action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = Brightness.dark == theme.primaryColorBrightness;
    var color = isDark ? Colors.white : Colors.black87;

    return RaisedButton(
      color: theme.primaryColor,
      padding: EdgeInsets.all(8.0),
      onPressed: () => action(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            width: 70.0,
            child: Icon(providerIcon, color: color),
          ),
          Expanded(
            child: Center(
              child: Text('Email Sign in', style: TextStyle(color: color)),
            ),
          ),
          Container(
            width: 70.0,
          ),
        ],
      ),
    );
  }
}
