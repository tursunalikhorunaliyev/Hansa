import 'dart:async';

class BlocFullRegister {
  final a = StreamController<String>.broadcast();
  StreamSink<String> get ak => a.sink;
  Stream<String> get am => a.stream;
  final b = StreamController<String>.broadcast();
  StreamSink<String> get bk => a.sink;
  Stream<String> get bm => a.stream;
  final c = StreamController<String>.broadcast();
  StreamSink<String> get ck => a.sink;
  Stream<String> get cm => a.stream;
}
