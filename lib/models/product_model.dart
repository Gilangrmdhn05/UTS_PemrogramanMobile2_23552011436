class ProductModel {
  final String id;
  final String name;
  final int price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      price: (map['price'] is int) ? map['price'] as int : int.tryParse(map['price']?.toString() ?? '') ?? 0,
      image: map['image']?.toString() ?? '',
    );
  }
}
