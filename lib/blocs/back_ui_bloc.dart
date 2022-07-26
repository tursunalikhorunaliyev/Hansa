import 'dart:async';

import 'package:hansa_app/blocs/menu_events_bloc.dart';

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
  //aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
}
