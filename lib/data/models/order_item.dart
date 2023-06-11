class OrderItem {
  final String id;
  final String name;
  final String image;
  final String size;
  final double price;
  final List<String> sizes;

  OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    this.sizes = const [],
  });

  OrderItem copyWith({
    String? id,
    String? name,
    String? image,
    String? size,
    double? price,
    List<String>? sizes,
  }) {
    return OrderItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'size': size,
      'price': price,
      'sizes': sizes,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      size: map['size'],
      price: map['price'],
      sizes: List<String>.from(map['sizes']),
    );
  }
}
