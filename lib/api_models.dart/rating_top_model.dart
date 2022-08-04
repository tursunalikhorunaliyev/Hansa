class RatingTopModel {
  bool status;
  RatingListData data;
  RatingTopModel({
    required this.status,
    required this.data,
  });

  factory RatingTopModel.fromMap(Map<String, dynamic> map) {
    return RatingTopModel(
      status: map['status'] as bool,
      data: RatingListData.fromMap(map['data']),
    );
  }
}

class RatingListData {
  List<RatingTopModelData> list;
  RatingListData({
    required this.list,
  });

  factory RatingListData.fromMap(List<dynamic> map) {
    return RatingListData(
      list: map.map((e) => RatingTopModelData.fromMap(e)).toList(),
    );
  }
}

class RatingTopModelData {
  String shop_net;
  String name;
  String score;
  RatingTopModelData({
    required this.shop_net,
    required this.name,
    required this.score,
  });

  factory RatingTopModelData.fromMap(Map<String, dynamic> map) {
    return RatingTopModelData(
      shop_net: map['shop_net'] as String,
      name: map['name'] as String,
      score: map['score'] as String,
    );
  }
}
