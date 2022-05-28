import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  final int? id;
  final String? title;
  final String? content;
  final Color? color;

  static const Map<String, Color> colors = {
    "red": Colors.red,
    "green": Colors.green,
    "blue": Colors.blue,
    "orange": Colors.orange,
    "pink": Colors.pink,
    "purple": Colors.purple,
  };

  const Note({
    this.id,
    this.title,
    this.content,
    this.color,
  });

  factory Note.fromMap(Map inMap) => Note(
        id: inMap["id"],
        title: inMap["title"],
        content: inMap["content"],
        color: inMap["color"],
      );

  Map<String, dynamic> toMap(Note note) {
    return {
      "id": note.id,
      "title": note.title,
      "content": note.content,
      "color": note.color,
    };
  }

  @override
  String toString() {
    return "{ id=$id, title=$title, content=$content, color=$color }";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        color,
      ];

  Note copyWith({
    int? id,
    String? title,
    String? content,
    Color? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
    );
  }
}
