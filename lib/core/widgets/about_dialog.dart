import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' hide showLicensePage, LicensePage;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:ezsale/core/pages/license_page.dart';

class AboutDialog extends StatelessWidget {
  const AboutDialog(
    {
      Key key,
      this.applicationName,
      this.applicationVersion,
      this.applicationIcon,
      this.applicationLegalese,
      this.children,
    }
  ) : super(key: key);

  final String applicationName;
  final String applicationVersion;
  final Widget applicationIcon;
  final String applicationLegalese;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final String name = applicationName ?? _defaultApplicationName(context);
    final String version = applicationVersion;
    final Widget icon = applicationIcon;

    List<Widget> body =[];

    if (icon != null) {
      body.add(IconTheme(data: const IconThemeData(size: 48.0), child: icon));
    }

    body.add(Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListBody(
          children: <Widget>[
            Text(name, style: Theme.of(context).textTheme.headline),
            Text(version, style: Theme.of(context).textTheme.body1),
            Container(height: 18.0),
            Text(applicationLegalese ?? '', style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    ));

    body = <Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: body),
    ];

    if (children != null) {
      body.addAll(children);
    }

    return new PlatformAlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: body,
        ),
      ),
      actions: <Widget>[
        PlatformDialogAction(
          child: PlatformText('View licenses'),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationIcon: applicationIcon,
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationLegalese: applicationLegalese,
            );
          },
        ),
        PlatformDialogAction(
          child: PlatformText('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

String _defaultApplicationName(BuildContext context) {
  final Title ancestorTitle = context.ancestorWidgetOfExactType(Title);
  return ancestorTitle?.title ??
      Platform.resolvedExecutable.split(Platform.pathSeparator).last;
}

void showLicensePage(
  {
    @required BuildContext context,
    String applicationName,
    String applicationVersion,
    Widget applicationIcon,
    String applicationLegalese
  }
) {
  Navigator.pop(context);
  Navigator.push(
    context,
    new MaterialPageRoute<void>(
      builder: (BuildContext context) => LicensePage(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationLegalese: applicationLegalese
      )
    ),
  );
}
