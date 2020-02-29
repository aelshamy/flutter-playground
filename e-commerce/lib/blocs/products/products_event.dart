part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetProducts extends ProductsEvent {
  final Category category;

  const GetProducts({this.category});

  @override
  List<Object> get props => [category];
}
