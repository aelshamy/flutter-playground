import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/providers/api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("FetchTopIds returns list of Ids", () async {
    final mockClient = MockClient((request) async {
      return Response(jsonEncode(<int>[1, 2, 3, 4]), 200);
    });
    final ApiProvider apiProvider = ApiProvider(client: mockClient);

    final ids = await apiProvider.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test("FetchItem returns an item model ", () async {
    final mockClient = MockClient((request) async {
      return Response(jsonEncode({"id": 123}), 200);
    });
    final ApiProvider apiProvider = ApiProvider(client: mockClient);

    final item = await apiProvider.fetchItem(123);

    expect(item.id, 123);
  });
}
