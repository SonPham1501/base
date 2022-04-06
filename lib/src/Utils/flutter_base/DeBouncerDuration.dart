import 'dart:async';

class DeBouncerDuration {
  Duration delay;
  Timer? _timer;
  Function? _callback;

  DeBouncerDuration({this.delay = const Duration(milliseconds: 500)});

  void debounce(Function callback) {
    this._callback = callback;

    this.cancel();
    _timer = new Timer(delay, this.flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void flush() {
    this._callback!();
    this.cancel();
  }
}