import 'dart:async';
import 'dart:io' show Platform;
import 'dart:developer' show Timeline, Flow;

import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide Flow;
import 'package:flutter/material.dart' hide Flow;

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LicensePage extends StatefulWidget {
  const LicensePage(
    {
      Key key,
      this.applicationName,
      this.applicationVersion,
      this.applicationLegalese
    }
  ) : super(key: key);

  final String applicationName;
  final String applicationVersion;
  final String applicationLegalese;

  @override
  _LicensePageState createState() => new _LicensePageState();
}

class _LicensePageState extends State<LicensePage> {
  @override
  void initState() {
    super.initState();
    _initLicenses();
  }

  final List<Widget> _licenses = <Widget>[];
  bool _loaded = false;

  Future<Null> _initLicenses() async {
    final Flow flow = Flow.begin();
    Timeline.timeSync('_initLicenses()', () {}, flow: flow);

    await for (LicenseEntry license in LicenseRegistry.licenses) {
      if (!mounted) {
        return;
      }

      Timeline.timeSync('_initLicenses()', () {}, flow: Flow.step(flow.id));

      final List<LicenseParagraph> paragraphs =
        await SchedulerBinding.instance.scheduleTask<List<LicenseParagraph>>(
          () => license.paragraphs.toList(),
          Priority.animation,
          debugLabel: 'License',
          flow: flow
        );

      setState(() {
        _licenses.add(const Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: const Text(
            '🍀',
            textAlign: TextAlign.center
          ),
        ));

        _licenses.add(Container(
          decoration: const BoxDecoration(
            border: const Border(bottom: const BorderSide(width: 0.0))
          ),
          child: Text(
            license.packages.join(', '),
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));

        for (LicenseParagraph paragraph in paragraphs) {
          if (paragraph.indent == LicenseParagraph.centeredIndent) {
            _licenses.add(Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                paragraph.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            assert(paragraph.indent >= 0);
            _licenses.add(Padding(
              padding: EdgeInsetsDirectional.only(top: 8.0, start: 16.0 * paragraph.indent),
              child: Text(paragraph.text),
            ));
          }
        }
      });
    }

    Timeline.timeSync('_initLicenses()', () {}, flow: Flow.end(flow.id));
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.applicationName ?? _defaultApplicationName(context);
    final String version = widget.applicationVersion;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> contents = <Widget>[
      new Text(name,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center),
      new Text(version,
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center),
      new Container(height: 18.0),
      new Text(widget.applicationLegalese ?? '',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center),
      new Container(height: 18.0),
      new Text('Powered by Flutter',
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center),
      new Container(height: 24.0),
    ];

    contents.addAll(_licenses);

    if (!_loaded) {
      contents.add(
        const Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: const Center(child: const CircularProgressIndicator()),
        )
      );
    }

    return new PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(localizations.licensesPageTitle),
      ),
      body: Localizations.override(
        locale: const Locale('en', 'US'),
        context: context,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.caption,
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              children: contents,
            ),
          ),
        ),
      ),
    );
  }
}

String _defaultApplicationName(BuildContext context) {
  final Title ancestorTitle = context.ancestorWidgetOfExactType(Title);
  return ancestorTitle?.title ??
      Platform.resolvedExecutable.split(Platform.pathSeparator).last;
}
