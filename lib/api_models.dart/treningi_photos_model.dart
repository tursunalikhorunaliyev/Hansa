class TreningiPhotosModel {
  bool status;
  TreningiPhotosdModelListData data;
  TreningiPhotosModel({
    required this.status,
    required this.data,
  });

  factory TreningiPhotosModel.fromMap(Map<String, dynamic> map) {
    return TreningiPhotosModel(
      status: map['status'],
      data: TreningiPhotosdModelListData.fromMap(map['data']),
    );
  }
}

class TreningiPhotosdModelListData {
  List<TreningiPhotosdModelData> list;
  TreningiPhotosdModelListData({
    required this.list,
  });

  factory TreningiPhotosdModelListData.fromMap(List<dynamic> map) {
    return TreningiPhotosdModelListData(
      list: map.map((e) => TreningiPhotosdModelData.fromMap(e)).toList(),
    );
  }
}

class TreningiPhotosdModelData {
  String title;
  String picture_link;
  TreningiPhotosdModelData({
    required this.title,
    required this.picture_link,
  });

  factory TreningiPhotosdModelData.fromMap(Map<String, dynamic> map) {
    return TreningiPhotosdModelData(
      title: map['title'] as String,
      picture_link: map['picture_link'] as String,
    );
  }
}
