import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/api/db_api.dart';
import 'package:ecommerce/models/category.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<GetCategories>((event, emit) {
      _mapGetCategoriesToState();
    });
    on<ListCategories>((event, emit) {
      emit(CategoriesLoaded(categories: event.categories));
    });
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
