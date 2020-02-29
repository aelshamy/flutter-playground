import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/api/db_api.dart';
import 'package:ecommerce/models/category.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  @override
  CategoriesState get initialState => CategoriesInitial();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCategories) {
      yield* _mapGetCategoriesToState();
    }
    if (event is ListCategories) {
      yield CategoriesLoaded(categories: event.categories);
    }
  }

  Stream<CategoriesState> _mapGetCategoriesToState() async* {
    final List<Category> categories = [];
    final DbApi dbApi = DbApi();
    dbApi.getCategories().listen((snapshot) {
      final List<Category> tempCategories = [];
      for (final DocumentSnapshot doc in snapshot.documents) {
        final Category category = Category.fromFirestore(doc.data);
        category.id = doc.documentID;
        tempCategories.add(category);
      }
      categories.addAll(tempCategories);
      add(ListCategories(categories: categories));
    });
  }
}
