import 'package:ecommerce/blocs/categories/categories_bloc.dart';
import 'package:ecommerce/blocs/products/products_bloc.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/pages/selected_category_page.dart';
import 'package:ecommerce/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce'),
        actions: <Widget>[CartButton()],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoaded) {
            final categories = state.categories;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return ListTile(
                  title: Text(
                    category.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  onTap: () {
                    navigateToSelectedCategory(context, category);
                  },
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

  void navigateToSelectedCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc()..add(GetProducts(category: category)),
          child: SelectedCategory(),
        ),
      ),
    );
  }
}
