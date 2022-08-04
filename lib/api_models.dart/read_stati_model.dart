class ReadStatiModel {
  bool status;
  ReadStatiArticle article;
  ReadStatiModel({required this.status, required this.article});
  factory ReadStatiModel.fromMap(Map<String, dynamic> map) {
    return ReadStatiModel(
        status: map["status"], article: ReadStatiArticle.fromMap(map["data"]));
  }
}

class ReadStatiArticle {
  ReadStatiModelApi read;
  ReadStatiArticle({required this.read});
  factory ReadStatiArticle.fromMap(Map<String, dynamic> map) {
    return ReadStatiArticle(read: ReadStatiModelApi.fromMap(map["article"]));
  }
}

class ReadStatiModelApi {
  String title;
  String pictureLink;
  String body;
  double rating;
  ReadStatiModelApi(
      {required this.title,
      required this.pictureLink,
      required this.body,
      required this.rating});
  factory ReadStatiModelApi.fromMap(Map<String, dynamic> map) {
    return ReadStatiModelApi(
        title: map["title"],
        pictureLink: map["picture_link"],
        body: map["body"],
        rating: map["rating"]);
  }
}
