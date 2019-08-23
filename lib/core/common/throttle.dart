import 'dart:async';

typedef void ValueCallback(dynamic value);
typedef dynamic ResultCallback();

class Throttler {
  Throttler({this.delay, this.callback, this.argCallback, this.noTrailing = false});

  Duration delay;
  ValueCallback callback;
  ResultCallback argCallback;
  bool noTrailing;

  Timer timer;

  DateTime now = new DateTime.now();

  void throttle() {
    Duration elapsed = new DateTime.now().difference(now);

    void exec() {
      now = new DateTime.now();
      callback(argCallback());
    }

    if (elapsed.compareTo(delay) >= 0) {
      exec();
    }

    if (timer != null) timer.cancel();

    if (noTrailing == false) {
      timer = new Timer(delay, exec);
    }
  }
}
