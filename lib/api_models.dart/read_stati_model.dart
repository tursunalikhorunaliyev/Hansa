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
  int id;
  String title;
  String pictureLink;
  String body;
  String messages;
  String messages_link;
  double rating;
  ReadStatiModelApi(
      {required this.id,
      required this.title,
      required this.pictureLink,
      required this.body,
      required this.messages,
      required this.messages_link,
      required this.rating});
  factory ReadStatiModelApi.fromMap(Map<String, dynamic> map) {
    return ReadStatiModelApi(
        id: map["id"],
        title: map["title"],
        pictureLink: map["picture_link"],
        body: map["body"],
        messages: map["messages"],
        messages_link: map["messages_link"],
        rating: map["rating"]);
  }
}
