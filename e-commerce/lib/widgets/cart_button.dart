import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) => CartPage()));
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartHasProducts) {
              return Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    state.itemCount != null ? state.itemCount?.toString() : 0.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
