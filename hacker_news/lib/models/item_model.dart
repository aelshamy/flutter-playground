import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<int> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel({
    required this.id,
    required this.deleted,
    required this.type,
    required this.by,
    required this.time,
    required this.text,
    required this.dead,
    required this.parent,
    required this.kids,
    required this.url,
    required this.score,
    required this.title,
    required this.descendants,
  });

  static ItemModel fromJson(Map<String, dynamic> map) => ItemModel(
        id: map['id'],
        deleted: map['deleted'] ?? false,
        type: map['type'],
        by: map['by'],
        time: map['time'],
        text: map['text'],
        dead: map['dead'] ?? false,
        parent: map['parent'],
        kids: map['kids'] != null ? (map['kids'] as List).cast<int>() : [],
        url: map['url'],
        score: map['score'],
        title: map['title'],
        descendants: map['descendants'],
      );

  static ItemModel fromDb(Map<String, dynamic> map) => ItemModel(
        id: map['id'],
        deleted: map['deleted'] == 1,
        type: map['type'],
        by: map['by'],
        time: map['time'],
        text: map['text'],
        dead: map['dead'] == 1,
        parent: map['parent'],
        kids: (jsonDecode(map['kids']) as List).cast<int>(),
        url: map['url'],
        score: map['score'],
        title: map['title'],
        descendants: map['descendants'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'deleted': deleted ? 1 : 0,
        'type': type,
        'by': by,
        'time': time,
        'text': text,
        'dead': dead ? 1 : 0,
        'parent': parent,
        'kids': jsonEncode(kids),
        'url': url,
        'score': score,
        'title': title,
        'descendants': descendants,
      };
}
