import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/blocs/products/products_bloc.dart';
import 'package:ecommerce/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Category'),
        actions: <Widget>[CartButton()],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            final products = state.products;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];

                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black26,
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              shape: const CircleBorder(side: BorderSide.none),
                              color: Colors.green,
                              onPressed: () => BlocProvider.of<CartBloc>(context)
                                  .add(AddProductToCart(product: product)),
                              child: Icon(Icons.add),
                            ),
                            FlatButton(
                              shape: const CircleBorder(side: BorderSide.none),
                              color: Colors.red,
                              onPressed: () => BlocProvider.of<CartBloc>(context)
                                  .add(RemoveProductFromCart(product: product)),
                              child: Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
