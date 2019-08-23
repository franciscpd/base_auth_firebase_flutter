import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:ezsale/core/widgets/screen_aware_padding.dart';

Future<T> openDialog<T>(
  {@required BuildContext context, @required WidgetBuilder builder}
) {
  var size = MediaQuery.of(context).size;

  bool isMobile = size.width < 660 || size.height < 660;

  if (isMobile) {
    return Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: builder));
  }

  return showDialog(
    context: context,
    builder: (ctx) => ScreenAwarePadding(child: builder(ctx)),
    barrierDismissible: false,
  );
}
