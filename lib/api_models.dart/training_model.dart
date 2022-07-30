class TrainingModel {
  bool status;
  TraningModelData data;
  TrainingModel({
    required this.status,
    required this.data,
  });

  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      status: map['status'] as bool,
      data: TraningModelData.fromMap(map['data']),
    );
  }
}

class TraningModelData {
  String webinar;
  FutureEvents futureEvents;
  Videos videos;
  EventReports eventReports;
  TraningModelData({
    required this.webinar,
    required this.futureEvents,
    required this.videos,
    required this.eventReports,
  });

  factory TraningModelData.fromMap(Map<String, dynamic> map) {
    return TraningModelData(
      webinar: map['webinar'] as String,
      futureEvents: FutureEvents.fromMap(map['futureEvents']),
      videos: Videos.fromMap(map['videos']),
      eventReports: EventReports.fromMap(map['eventReports']),
    );
  }
}

class Events {}

class FutureEvents {
  List<FutureEventsData> list;
  FutureEvents({
    required this.list,
  });

  factory FutureEvents.fromMap(List<dynamic> map) {
    return FutureEvents(
      list: map.map((e) => FutureEventsData.fromMap(e)).toList(),
    );
  }
}

class FutureEventsData {
  String title;
  bool checked;
  String link;
  FutureEventsData({
    required this.title,
    required this.checked,
    required this.link,
  });

  factory FutureEventsData.fromMap(Map<String, dynamic> map) {
    return FutureEventsData(
      title: map['title'] as String,
      checked: map['checked'] as bool,
      link: map['_link'] as String,
    );
  }
}

class Videos {
  List<VideosData> list;
  Videos({
    required this.list,
  });

  factory Videos.fromMap(List<dynamic> map) {
    return Videos(
      list: map.map((e) => VideosData.fromMap(e)).toList(),
    );
  }
}

class VideosData {
  String title;
  String link;
  VideosData({
    required this.title,
    required this.link,
  });

  factory VideosData.fromMap(Map<String, dynamic> map) {
    return VideosData(
      title: map['title'] as String,
      link: map['_link'] as String,
    );
  }
}

class EventReports {
  List<EventReportsData> list;
  EventReports({
    required this.list,
  });

  factory EventReports.fromMap(List<dynamic> map) {
    return EventReports(
      list: map.map((e) => EventReportsData.fromMap(e)).toList(),
    );
  }
}

class EventReportsData {
  String title;
  String link;
  EventReportsData({
    required this.title,
    required this.link,
  });

  factory EventReportsData.fromMap(Map<String, dynamic> map) {
    return EventReportsData(
      title: map['title'] as String,
      link: map['_link'] as String,
    );
  }
}
