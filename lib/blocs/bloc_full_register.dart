import 'dart:async';

class BlocFullRegister {
  final a = StreamController<String>.broadcast();
  StreamSink<String> get ak => a.sink;
  Stream<String> get am => a.stream;
  final b = StreamController<String>.broadcast();
  StreamSink<String> get bk => b.sink;
  Stream<String> get bm => b.stream;
  final c = StreamController<String>.broadcast();
  StreamSink<String> get ck => c.sink;
  Stream<String> get cm => c.stream;
}
