// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  ListMessageComment listMessageComment;
  String messages_link;
  double rating;
  ReadStatiModelApi({
    required this.id,
    required this.title,
    required this.pictureLink,
    required this.body,
    required this.listMessageComment,
    required this.messages_link,
    required this.rating,
  });

  factory ReadStatiModelApi.fromMap(Map<String, dynamic> map) {
    return ReadStatiModelApi(
      id: map['id'],
      title: map['title'],
      pictureLink: map['picture_link'],
      body: map['body'],
      listMessageComment: ListMessageComment.fromJson(map["messages"]),
      messages_link: map['messages_link'],
      rating: map['rating'],
    );
  }
}

class ListMessageComment {
  List<MessageComment> list;
  ListMessageComment({required this.list});

  factory ListMessageComment.fromJson(List<dynamic> map) {
    return ListMessageComment(
        list: map.map((e) => MessageComment.fromJson(e)).toList());
  }
}

class MessageComment {
  String fullname;
  String date;
  String body;
  String picture_link;
  dynamic rang;
  MessageComment(
      {required this.fullname,
      required this.date,
      required this.body,
      required this.picture_link,
      required this.rang});

  factory MessageComment.fromJson(Map<String, dynamic> map) {
    return MessageComment(
        fullname: map["fullname"],
        date: map["date"],
        body: map["body"],
        picture_link: map["picture_link"],
        rang: map["rang"]);
  }
}
