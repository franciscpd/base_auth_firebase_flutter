import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:ezsale/core/common/throttle.dart';

class ThrottledTextEditingController extends TextEditingController {
  ThrottledTextEditingController(
    {
      @required ValueCallback onUpdate,
      int throttleDurationMilliseconds = 1000
    }
  ) {
    _textThrottler = new Throttler(
      delay: Duration(milliseconds: throttleDurationMilliseconds),
      callback: onUpdate,
      argCallback: () => this.text,
    );

    super.addListener(_textThrottler.throttle);
  }

  Throttler _textThrottler;
}
