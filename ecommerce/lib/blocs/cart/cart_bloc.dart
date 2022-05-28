import 'package:bloc/bloc.dart';
import 'package:ecommerce/models/product.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartEmpty()) {
    on<AddProductToCart>((event, emit) {
      if (state is CartEmpty) {
        final List<Product> products = [];
        event.product.amount = 1;
        products.add(event.product);
        emit(CartHasProducts(itemCount: 1, products: products));
      } else {
        final currentState = state as CartHasProducts;
        final products = currentState.products;
        if (products.contains(event.product)) {
          products[products.indexOf(event.product)].amount++;
        } else {
          event.product.amount = 1;
          products.add(event.product);
        }
        emit(CartHasProducts(
            products: products, itemCount: currentState.itemCount + 1));
      }
    });

    on<RemoveProductFromCart>((event, emit) {
      if (state is! CartEmpty) {
        final currentState = state as CartHasProducts;
        final List<Product> products = currentState.products;
        if (products.contains(event.product)) {
          if (event.product.amount > 1) {
            event.product.amount--;
            emit(
              CartHasProducts(
                  products: products, itemCount: currentState.itemCount - 1),
            );
          } else {
            products.removeAt(products.indexOf(event.product));

            if (currentState.itemCount < 2) {
              emit(const CartEmpty());
            } else {
              emit(
                CartHasProducts(
                  products: products,
                  itemCount: currentState.itemCount - 1,
                ),
              );
            }
          }
        }
      }
    });
  }
}
