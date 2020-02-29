class Category {
  String id;
  String name;

  Category() {
    name = "motherboard";
  }

  Category.fromFirestore(Map<String, dynamic> json) {
    name = json['name'] as String;
  }
}
