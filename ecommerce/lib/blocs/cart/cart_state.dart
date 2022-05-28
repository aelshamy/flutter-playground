part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartEmpty extends CartState {
  final String message;

  const CartEmpty({this.message = "your cart is empty"});

  @override
  List<Object> get props => [message];
}

class CartHasProducts extends CartState {
  final int itemCount;
  final List<Product> products;

  const CartHasProducts({this.itemCount = 0, this.products = const []});

  @override
  List<Object> get props => [itemCount, products];
}
