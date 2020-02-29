import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/models/product.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => const CartEmpty();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddProductToCart) {
      yield* _mapAddProductToState(event.product);
    }
    if (event is RemoveProductFromCart) {
      yield* _mapRemoveProductToState(event.product);
    }
  }

  Stream<CartState> _mapAddProductToState(Product product) async* {
    if (state is CartEmpty) {
      final List<Product> products = [];
      product.amount = 1;
      products.add(product);
      yield CartHasProducts(itemCount: 1, products: products);
    } else {
      final currentState = state as CartHasProducts;
      final products = currentState.products;
      if (products.contains(product)) {
        products[products.indexOf(product)].amount++;
      } else {
        product.amount = 1;
        products.add(product);
      }
      yield CartHasProducts(products: products, itemCount: currentState.itemCount + 1);
    }
  }

  Stream<CartState> _mapRemoveProductToState(Product product) async* {
    if (state is! CartEmpty) {
      final currentState = state as CartHasProducts;
      final List<Product> products = currentState.products;
      if (products.contains(product)) {
        if (product.amount > 1) {
          product.amount--;
          yield CartHasProducts(products: products, itemCount: currentState.itemCount - 1);
        } else {
          products.removeAt(products.indexOf(product));

          if (currentState.itemCount < 2) {
            yield const CartEmpty();
          } else {
            yield CartHasProducts(products: products, itemCount: currentState.itemCount - 1);
          }
        }
      }
    }
  }
}
