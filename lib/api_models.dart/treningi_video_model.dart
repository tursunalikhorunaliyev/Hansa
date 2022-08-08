class TreningiVideoModel {
  bool status;
  TreningiVideoModelData data;
  TreningiVideoModel({required this.data, required this.status});
  factory TreningiVideoModel.fromMap(Map<String, dynamic> map) {
    return TreningiVideoModel(
      status: map['status'],
      data: TreningiVideoModelData.fromMap(map['data']),
    );
  }
}

class TreningiVideoModelData {
  String title;
  String pictureLink;
  String videoLink;
  TreningiVideoModelData({
    required this.title,
    required this.pictureLink,
    required this.videoLink,
  });

  factory TreningiVideoModelData.fromMap(Map<String, dynamic> map) {
    return TreningiVideoModelData(
      title: map['title'] as String,
      pictureLink: map['picture_link'] as String,
      videoLink: map['video_link'] as String,
    );
  }
}
