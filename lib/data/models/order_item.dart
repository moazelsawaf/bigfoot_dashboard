class OrderItem {
  final int id;
  final String name;
  final String image;
  final String size;
  final double price;
  final List<String> sizes;

  OrderItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.size,
      required this.price,
      this.sizes = const []});
}
