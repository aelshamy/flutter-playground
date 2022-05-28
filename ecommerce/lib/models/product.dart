import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? name;
  String? imageUrl;
  String? id;
  int? amount;

  static const nameKey = 'name';
  static const imageUrlKey = 'imageUrl';

  Product({required this.name});

  Product.fromFirestore(Map<String, dynamic> json) {
    name = json[nameKey] as String;
    imageUrl = json[imageUrlKey] as String;
  }

  @override
  List<Object?> get props => [name, imageUrl, id, amount];
}
