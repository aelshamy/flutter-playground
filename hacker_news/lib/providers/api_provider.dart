import 'dart:convert';

import 'package:hacker_news/models/item_model.dart';
import 'package:hacker_news/repository/source.dart';
import 'package:http/http.dart' show Client;

class ApiProvider implements Source {
  final Client _client;
  final baseUrl = "https://hacker-news.firebaseio.com/v0";

  ApiProvider({Client client}) : _client = client ?? Client();

  @override
  Future<List<int>> fetchTopIds() async {
    List<dynamic> ids;
    try {
      final response = await _client.get("$baseUrl/topstories.json");
      ids = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await _client.get("$baseUrl/item/$id.json");
    final parsedJson = jsonDecode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
