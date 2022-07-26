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
class MenuEventsBloC{

  final eventController = StreamController<MenuActions>.broadcast();
  StreamSink<MenuActions> get eventSink => eventController.sink;
  Stream<MenuActions> get eventStream => eventController.stream;
}