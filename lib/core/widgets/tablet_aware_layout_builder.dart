import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class TabletAwareLayoutBuilder extends StatelessWidget {
  TabletAwareLayoutBuilder(
    {
      Key key, @required this.mobileView, @required this.tabletView
    }
  ) : assert(mobileView != null), assert(tabletView != null), super(key: key);

  final WidgetBuilder mobileView;
  final WidgetBuilder tabletView;

  final double tabletThreshold = 660.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        final bool useMobileLayout = contraints.maxWidth < tabletThreshold;

        if (useMobileLayout) {
          return mobileView(context);
        }

        return tabletView(context);
      },
    );
  }
}
