import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String content;
  final String color;

  static const Map<String, Color> colors = {
    "red": Colors.red,
    "green": Colors.green,
    "blue": Colors.blue,
    "orange": Colors.orange,
    "grey": Colors.grey,
    "purple": Colors.purple,
  };

  Note({this.id, this.title, this.content, this.color});

  @override
  String toString() {
    return "{ id=$id, title=$title, "
        "content=$content, color=$color }";
  }

  factory Note.fromJson(Map inMap) => Note(
        id: inMap["id"],
        title: inMap["title"],
        content: inMap["content"],
        color: inMap["color"],
      );

  Map<String, dynamic> toJson(Note note) {
    return {
      "id": note.id,
      "title": note.title,
      "content": note.content,
      "color": note.color,
    };
  }

  @override
  List<Object> get props => [id, title, content, color];
}
