import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/api/db_api.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is GetProducts) {
      yield* _mapGetProductsToState(event.category);
    }
  }

  Stream<ProductsState> _mapGetProductsToState(Category category) async* {
    final dbApi = DbApi();
    final List<Product> products = [];
    dbApi.getProducts(category).listen((snapshot) {
      final List<Product> tempProducts = [];
      for (final DocumentSnapshot doc in snapshot.documents) {
        final Product product = Product.fromFirestore(doc.data);
        product.id = doc.documentID;
        tempProducts.add(product);
      }

      products.addAll(tempProducts);
    });
    yield ProductsLoaded(products: products);
  }
}
