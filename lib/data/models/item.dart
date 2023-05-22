class ItemModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final List<String> sizes;

  ItemModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      this.sizes = const []});

  ItemModel copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
    List<String>? sizes,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'sizes': sizes,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      sizes: List<String>.from(map['sizes']),
    );
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, image: $image, price: $price, sizes: $sizes)';
  }
}
