class StatiComentModel {
  bool status;
  Data data;
  StatiComentModel({
    required this.status,
    required this.data,
  });

  factory StatiComentModel.fromMap(Map<String, dynamic> map) {
    return StatiComentModel(
      status: map['status'],
      data: Data.fromMap(map['data']),
    );
  }
}

class Data {
  List<Indata> list;
  Data({
    required this.list,
  });

  factory Data.fromMap(List<dynamic> map) {
    return Data(list: map.map((e) => Indata.fromMap(e)).toList());
  }
}

class Indata {
  String fullname;
  String date;
  String body;
  String picture_link;
  String rang;
  Indata({
    required this.fullname,
    required this.date,
    required this.body,
    required this.picture_link,
    required this.rang,
  });

  factory Indata.fromMap(Map<String, dynamic> map) {
    return Indata(
      fullname: map['fullname'] as String,
      date: map['date'] as String,
      body: map['body'] as String,
      picture_link: map['picture_link'] as String,
      rang: map['rang'].toString(),
    );
  }
}
