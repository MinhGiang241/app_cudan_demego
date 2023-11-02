import 'dart:async';

class StreamCount {
  StreamCount();
  static final shared = StreamCount();
  StreamController controller = StreamController();
}
