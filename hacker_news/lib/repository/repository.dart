import 'package:hacker_news/models/item_model.dart';
import 'package:hacker_news/providers/api_provider.dart';
import 'package:hacker_news/providers/db_provider.dart';
import 'package:hacker_news/repository/cache.dart';
import 'package:hacker_news/repository/source.dart';

class Repository {
  final List<Source> _sources;
  final List<Cache> _caches;

  Repository(List<Source> sources, List<Cache> caches)
      : _sources = sources ?? [DbProvider.instance, ApiProvider()],
        _caches = caches ?? [DbProvider.instance];

  Future<List<int>> fetchTopIds() async {
    List<int> items;
    for (final source in _sources) {
      items = await source.fetchTopIds();
      if (items != null) {
        break;
      }
    }
    return items;
  }

  Future<ItemModel> fetchItem(int id) async {
    // var item = await _dbProvider.fetchItem(id);
    // if (item != null) {
    //   return item;
    // }

    // item = await _apiProvider.fetchItem(id);
    // _dbProvider.addItem(item);
    // return item;

    ItemModel item;
    Source source;

    for (source in _sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in _caches) {
      cache.addItem(item);
    }

    return item;
  }
}
