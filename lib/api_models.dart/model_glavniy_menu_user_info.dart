
class ModelGlavniyMenuUserInfoMain {
  bool status;
  Data data;
  ModelGlavniyMenuUserInfoMain({
    required this.status,
    required this.data,
  });

  factory ModelGlavniyMenuUserInfoMain.fromMap(Map<String, dynamic> map) {
    return ModelGlavniyMenuUserInfoMain(
      status: map['status'],
      data: Data.fromMap(map['data']),
    );
  }
}

class Data {
  String fullname;
  int score;
  String ref_link;
  String link;
  Data({
    required this.fullname,
    required this.score,
    required this.ref_link,
    required this.link,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      fullname: map['fullname'],
      score: map['score'],
      ref_link: map['ref_link'],
      link: map['_link'],
    );
  }
}
