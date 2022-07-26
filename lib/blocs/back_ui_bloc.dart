import 'dart:async';
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
import 'package:hansa_app/blocs/menu_events_bloc.dart';
// Back UI BloC
class BackUIBloC {
  final controller = StreamController<MenuActions>();
  StreamSink<MenuActions> get sink => controller.sink;
  Stream<MenuActions> get stream => controller.stream;

  BackUIBloC() {
    final bloc = MenuEventsBloC();
    List<MenuActions> list = [MenuActions.welcome];
    stream.listen((event) {
      list.add(event);
      bloc.eventSink.add(list[list.length - 1]);
      list.removeAt(list.length - 1);
    });
  }
}
