import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ezsale/theme.dart';
import 'package:ezsale/core/app_info.dart';
import 'package:ezsale/core/app_model.dart';
import 'package:ezsale/routes.dart' as routing;
import 'package:ezsale/core/pages/splash_page.dart';
import 'package:ezsale/services/auth_service.dart' as auth;

final GlobalKey<NavigatorState> _navKey = new GlobalKey<NavigatorState>();

void main() {
  var appInfo = new AppInfo(
    appName: 'EZSale',
    appVersion: '0.0.1',
    appIconPath: 'assets/images/flutter-icon.png',
    avatarDefaultAppIconPath: 'assets/images/profile-icon.png',
    applicationLegalese: '',
    privacyPolicyUrl: 'https://sheet.best/#/privacy',
    termsOfServiceUrl: 'https://sheet.best/#/tos',
  );

  var authService = auth.createAuthService();

  var app = ScopedModel<AppModel>(
    model: AppModel(appInfo: appInfo, authService: authService),
    child: MaterialApp(
      title: appInfo.appName,
      navigatorKey: _navKey,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: Splash(),
      routes: routing.buildRoutes(authService),
      onGenerateRoute: routing.buildGenerator(),
    ),
  );

  authService.authUserChanged.addListener(() {
    app.model.refreshAuthUser().then((model) {
      if (model.hasChanged) {
        if (model.isValidUser) {
          _navKey.currentState.pushNamedAndRemoveUntil('/home', (_) => false);
        } else {
          _navKey.currentState.pushNamedAndRemoveUntil('/', (_) => false);
        }
      }
    });
  });

  runApp(app);
}
