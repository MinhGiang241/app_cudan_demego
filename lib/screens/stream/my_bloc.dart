import 'dart:async';

class MyBloc {
  int counter = 0;
  final StreamController _counterController = StreamController<int>.broadcast();
  Stream get counterStream =>
      _counterController.stream.transform(_counterTransformer);

  final _counterTransformer =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data += 10;
    sink.add(data);
  });
  dispose() {
    _counterController.close();
  }

  void increment() {
    counter++;
    _counterController.sink.add(counter);
  }

  void decrement() {
    counter--;
    _counterController.sink.add(counter);
  }
}
