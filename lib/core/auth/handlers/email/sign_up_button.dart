import 'package:flutter/material.dart';
import 'package:ezsale/core/auth/handlers/email/signUp/sign_up_page.dart';

void signUp(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPassword()));
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Not registered?',
            style: TextStyle(color: themeData.textTheme.body1.color),
          ),
        ),
        OutlineButton(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          textColor: themeData.primaryColor,
          onPressed: () => signUp(context),
          child: Text('Sign Up'),
        ),
      ],
    );
  }
}
