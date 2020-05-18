import 'package:hacker_news/models/item_model.dart';

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
