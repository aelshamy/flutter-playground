part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({@required this.products});

  @override
  List<Object> get props => [products];
}
