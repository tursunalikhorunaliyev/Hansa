class PrezintatsiaModel {
  bool status;
  PrezintatsiaModelData data;

  PrezintatsiaModel({required this.status, required this.data});
  factory PrezintatsiaModel.fromMap(Map<String, dynamic> map) {
    return PrezintatsiaModel(
        status: map["status"],
        data: PrezintatsiaModelData.fromMap(map["data"]));
  }
}

class PrezintatsiaModelData {
  PrezintatsiaModelGuidesList data;
  PrezintatsiaModelData({required this.data});
  factory PrezintatsiaModelData.fromMap(Map<String, dynamic> map) {
    return PrezintatsiaModelData(
        data: PrezintatsiaModelGuidesList.fromMap(map["guides"]));
  }
}

class PrezintatsiaModelGuidesList {
  List<PrezintatsiaModelGuidesItem> dataGuides;
  List<PrezintatsiaModelGuidesArchiveItem> dataGuidesArchive;

  PrezintatsiaModelGuidesList(
      {required this.dataGuides, required this.dataGuidesArchive});

  factory PrezintatsiaModelGuidesList.fromMap(List<dynamic> map) {
    return PrezintatsiaModelGuidesList(
        dataGuides:
            map.map((e) => PrezintatsiaModelGuidesItem.fromMap(e)).toList(),
        dataGuidesArchive: map
            .map((e) => PrezintatsiaModelGuidesArchiveItem.fromMap(e))
            .toList());
  }
}

class PrezintatsiaModelGuidesItem {
  String title;
  String pdfUrl;
  bool isFavourite;
  String picture_link;
  String favourite_link;
  String link;
  PrezintatsiaModelGuidesItem(
      {required this.title,
      required this.pdfUrl,
      required this.isFavourite,
      required this.picture_link,
      required this.favourite_link,
      required this.link});

  factory PrezintatsiaModelGuidesItem.fromMap(Map<String, dynamic> map) {
    return PrezintatsiaModelGuidesItem(
        title: map["title"],
        pdfUrl: map["PdfUrl"],
        isFavourite: map["isFavourite"],
        picture_link: map["picture_link"],
        favourite_link: map["favourite_link"],
        link: map["_link"]);
  }
}

class PrezintatsiaModelGuidesArchiveItem {
  String title;
  String pdfUrl;
  bool isFavourite;
  String picture_link;
  String favourite_link;
  String link;
  PrezintatsiaModelGuidesArchiveItem(
      {required this.title,
      required this.pdfUrl,
      required this.isFavourite,
      required this.picture_link,
      required this.favourite_link,
      required this.link});

  factory PrezintatsiaModelGuidesArchiveItem.fromMap(Map<String, dynamic> map) {
    return PrezintatsiaModelGuidesArchiveItem(
        title: map["title"],
        pdfUrl: map["PdfUrl"],
        isFavourite: map["isFavourite"],
        picture_link: map["picture_link"],
        favourite_link: map["favourite_link"],
        link: map["_link"]);
  }
}
