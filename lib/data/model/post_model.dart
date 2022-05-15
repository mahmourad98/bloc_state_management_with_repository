import 'package:flutter/material.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({@required this.userId, @required this.id, @required this.title, @required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    var userId = json['userId'] ?? 0;
    var id = json['id'] ?? 0;
    var title = json['title'];
    var body = json['body'];
    return Post(userId: userId,id: id, title: title, body: body,);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }

  @override
  String toString() {
    return "Post(userId: ${this.userId}, id: ${this.id}, title: ${this.title}, body: ${this.body})";
  }
}