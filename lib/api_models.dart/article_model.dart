class ArticleModel {
  bool status;
  ArticleModelBody article;
  ArticleModel({required this.status, required this.article});

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
        status: map["status"], article: ArticleModelBody.fromMap(map["data"]));
  }
}

class ArticleModelBody {
  String title;
  String body;
  String pucture_link;
  ArticleModelBody(
      {required this.title, required this.body, required this.pucture_link});

  factory ArticleModelBody.fromMap(Map<String, dynamic> map) {
    return ArticleModelBody(
        title: map["title"],
        body: map["body"],
        pucture_link: map["pucture_link"]);
  }
}
