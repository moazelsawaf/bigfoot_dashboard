class OrderItem {
  final int id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;
}
