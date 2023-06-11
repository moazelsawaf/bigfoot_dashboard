class ItemModel {
  String? id;
  final String name;
  final String image;
  final String description;
  final double price;
  final List<String> sizes;

  ItemModel({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.sizes = const [],
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    double? price,
    List<String>? sizes,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'desc': description,
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
      description: map['desc'],
      sizes: List<String>.from(map['sizes']),
    );
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, image: $image, price: $price, sizes: $sizes)';
  }
}
