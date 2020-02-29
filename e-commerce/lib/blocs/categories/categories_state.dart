part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoaded({this.categories});

  @override
  List<Object> get props => [categories];
}
