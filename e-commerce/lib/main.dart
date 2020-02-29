import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/blocs/categories/categories_bloc.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(
      BlocProvider<CartBloc>(
        create: (BuildContext context) => CartBloc(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        create: (BuildContext context) => CategoriesBloc()..add(const GetCategories()),
        child: HomePage(),
      ),
    );
  }
}
