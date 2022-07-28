import 'dart:async';

enum MenuActions {
  obuchayushieMaterial,
  prezintatsiya,
  stati,
  katalog,
  trening,
  video,
  oProyekt,
  welcome,
  presentAndArchive,
  chitatStati,
  trainingVideo,
  oKompanii
}

class MenuEventsBloC {
  List<MenuActions> list = [MenuActions.welcome];
  final eventController = StreamController<MenuActions>.broadcast();
  StreamSink<MenuActions> get eventSink => eventController.sink;
  Stream<MenuActions> get eventStream => eventController.stream;

  MenuEventsBloC() {
    eventStream.listen((event) {
      list.add(event);
    });
  }
}
