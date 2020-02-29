import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/category.dart';

class DbApi {
  // List<Category> getCategories() {
  //   List<Category> tempList = [
  //     Category(),
  //     Category(),
  //     Category(),
  //     Category(),
  //   ];
  //   return tempList;
  // }

  // List<Product> getProducts(Category category) {
  //   List<Product> tempList = [
  //     Product.create('product'),
  //     Product.create('product'),
  //     Product.create('product'),
  //   ];
  //   return tempList;
  // }
  Stream<QuerySnapshot> getCategories() {
    final Firestore db = Firestore.instance;
    try {
      final Stream<QuerySnapshot> querySnapShot = db.collection('Categories').snapshots();
      return querySnapShot;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot> getProducts(Category category) {
    final Firestore db = Firestore.instance;
    try {
      final Stream<QuerySnapshot> querySnapShot =
          db.collection('Categories').document(category.id).collection('parts').snapshots();
      return querySnapShot;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
