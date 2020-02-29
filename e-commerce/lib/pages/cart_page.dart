import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartEmpty) {
            return Center(child: Text(state.message));
          }
          final List<Product> products = (state as CartHasProducts).products;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                trailing: Text(product.amount.toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
