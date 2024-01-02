class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
  Map<String, dynamic> fromJSon() {
    return ({
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    });
  }
}
